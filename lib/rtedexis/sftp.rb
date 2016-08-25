require 'net/sftp'

class Rtedexis::SFTP 
  attr_accessor :last_file_sended	
  def initialize(options = {})
    @config = {host: '200.41.57.106'}
    config(options)
  end

  def config(options = {})
      options.each do |key,value|
        @config[key] = value
      end
    @config
  end 

  def send(args = {})
  	if args[:numbers_list].kind_of?(Array) and !args[:text].empty?
      file_content = generate_file_content(args[:numbers_list], args[:text])
  		args[:filename] ? write_file_to_sftp_server(file_content[:for_delivery], filename: args[:filename]) : write_file_to_sftp_server(file_content[:for_delivery])
  	end
    Response.new(invalid_numbers: file_content[:invalid_numbers], messages_sended: file_content[:messages_sended])
  end

  def send_with_diferent_text(numbers, args = {})
    file_content = generate_file_content_for_individual_messages(numbers)
    args[:filename] ? write_file_to_sftp_server(file_content[:for_delivery], filename: args[:filename]) : write_file_to_sftp_server(file_content[:for_delivery])
  end

  private

  	def generate_file_content(number_list, text)
  		result = {for_delivery: String.new, invalid_numbers: Array.new, messages_sended: 0}
  		number_list.each do |number|
        if is_in_cellphone_format?(number)
          sended_point = 0
    			 while text.length > sended_point
      				result[:for_delivery] << get_operator_code(number) + ';' + get_number_without_operator_code(number) + ';' + text[sended_point, 160] + "\n"
      				sended_point += 160 
              result[:messages_sended] += 1
    			 end
         else
           result[:invalid_numbers] << number  
         end
    	 end
  		result
  	end

    def generate_file_content_for_individual_messages(items)
      result = {for_delivery: String.new, invalid_numbers: Array.new, messages_sended: 0}
      items.each do |item|
        if is_in_cellphone_format?(item[:number])
          sended_point = 0
           while item[:text].length > sended_point
              result[:for_delivery] << get_operator_code(item[:number]) + ';' + get_number_without_operator_code(item[:number]) + ';' + item[:text][sended_point, 160] + "\n"
              sended_point += 160 
              result[:messages_sended] += 1 
           end
         else
           result[:invalid_numbers] << item  
         end
       end
      result
    end

  	def get_operator_code(number)
		if number[0] == '0'
			number[1,3]
		else
			number[0,3]
		end
	end

	def get_number_without_operator_code(number)
		if number[0] == '0'
			number[4,7]
		else
			number[3,7]
		end
	end

  	

  	def generate_file_name
  		"masivo_" + Time.now.to_i.to_s + ".txt" 
  	end

  	def write_file_to_sftp_server(content, args = {})
      args[:filename] ? file_name = args[:filename] : file_name = generate_file_name 
  		Net::SFTP.start(@config[:host], @config[:username], :password => @config[:password]) do |sftp|
  			sftp.file.open("/entrada/" + file_name, "w") do |msg|
  				msg.puts content
  			end
  		end
      @last_file_sended = file_name
  	end

    def is_in_cellphone_format?(number)
      true if is_number?(number) and (number.length == 10 or number.length == 11)
    end

    def is_number?(string)
      true if Integer(string) rescue false
    end
end