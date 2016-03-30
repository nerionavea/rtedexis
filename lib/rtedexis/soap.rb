require 'savon'
class Rtedexis::SOAP
  def initialize(options = {})
    @config = {wsdl: 'http://200.41.57.109:8086/m4.in.wsint/services/M4WSIntSR?wsdl'}
    config(options)
  end

  def config(options = {})
      options.each do |key,value|
        @config[key] = value
      end
    @config
  end

  def last_response
    @last_response
  end

  def send(to, text)
    client = Savon.client(wsdl: config[:wsdl])
    response = client.call(:send_sms, message: {
    'passport' => config[:passport], 
    'password' => config[:password], 
    'number' => to, 
    'text' => text}) 
    set_last_response(response) 
  end
  private
  

    def set_last_response(response)
      @last_response = response
    end


end
