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

  def send(number_list, text)
  	if number_list.kind_of?(Array) and !text.empty?
  		write_file_to_sftp_server(format_file_content(number_list, text))
  	end
  end

  private

  	def format_file_content(number_list, text)
  		result = ""
  		number_list.each do |number|
        sended_point = 0
  			while text.length > sended_point
  				result << get_operator_code(number) + ';' + get_number_without_operator_code(number) + ';' + text[sended_point, 160] + "\n"
  				sended_point += 160 
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

  	def write_file_to_sftp_server(content)
      file_name = generate_file_name
  		Net::SFTP.start(@config[:host], @config[:username], :password => @config[:password]) do |sftp|
  			sftp.file.open("/entrada/" + file_name, "w") do |msg|
  				msg.puts content
  			end
  		end
      @last_file_sended = file_name
  	end


end