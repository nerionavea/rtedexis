require 'test_helper'

class RtedexisTest < Test::Unit::TestCase
  def test_send_wdsl_request
  	sender = Rtedexis::SOAP.new
  	sender.send('584125491920', 'Hi!')
   assert_equal  sender.last_response.http.code, 200
  end


  test "on create set wsdl passport config" do
	  assert_equal Rtedexis::SOAP.new(wsdl: 'a').config, {wsdl: 'a'}
  end


  test "on create set passport config" do
  	assert_equal Rtedexis::SOAP.new(passport: 'a').config, {wsdl: 'http://200.41.57.109:8086/m4.in.wsint/services/M4WSIntSR?wsdl',
											             passport: 'a'}
  end

  test "on create set password config" do
  	assert_equal Rtedexis::SOAP.new(password: 'a').config, {wsdl: 'http://200.41.57.109:8086/m4.in.wsint/services/M4WSIntSR?wsdl',
               password: 'a'}
  end 

  
end
