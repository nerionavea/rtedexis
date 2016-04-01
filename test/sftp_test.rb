require 'test_helper'

class RtedexisTest < Test::Unit::TestCase
  #if you want test this you must write your credentials in @config
  def setup 
    @config = {
      username: 'uscas',
      password: '$usC4s'
    }
  end

  test "must create a config" do
    sender = Rtedexis::SFTP.new(host: '200.41.57-106', username: 'youruser', password: '$yourpassword')
    assert_equal sender.config, {host: '200.41.57-106', username: 'youruser', password: '$yourpassword'}
  end

  test "must create a file on server and write numbers and text for sending sms" do
     sender = Rtedexis::SFTP.new(host: '200.41.57.106', username: @config[:username], password: @config[:password])
     numbers_array = ['4125491920', '4168605522'] 
     sender.send(numbers_array, 'hola k ase')
     name_of_txt_file = sender.last_file_sended
     sftp = Net::SFTP.start('200.41.57.106', @config[:username], :password => @config[:password]) 
     data = sftp.download!("/entrada/" + name_of_txt_file).split(/\r\n/)
     assert_equal data, ["412;5491920;hola k ase\n416;8605522;hola k ase\n"]
   end

   test "sftp send must ommit numbers in a no cellphone format" do 
     sender = Rtedexis::SFTP.new(host: '200.41.57.106', username: @config[:username], password: @config[:password])
     numbers_array = ['4125491920', '4168605522', 'eac3414124', '345'] 
     response = sender.send(numbers_array, 'hola k ase')
     name_of_txt_file = sender.last_file_sended
     sftp = Net::SFTP.start('200.41.57.106', @config[:username], :password => @config[:password]) 
     data = sftp.download!("/entrada/" + name_of_txt_file).split(/\r\n/)
     assert_equal data, ["412;5491920;hola k ase\n416;8605522;hola k ase\n"]
     assert_equal response.invalid_numbers, ['eac3414124', '345']
   end
end