require 'test_helper'

class RtedexisTest < Test::Unit::TestCase
  test "must create a config" do
    sender = Rtedexis::SFTP.new(host: '200.41.57-106', username: 'youruser', password: '$yourpassword')
    assert_equal sender.config, {host: '200.41.57-106', username: 'youruser', password: '$yourpassword'}
  end

  test "must create a file on server and write numbers and text for sending sms" do
     sender = Rtedexis::SFTP.new(host: '200.41.57.106', username: 'youruser', password: '$yourpaswword')
     sender.send(['4125491920', '4168605522'], 'hola k ase')
     name_of_txt_file = sender.last_file_sended
     sftp = Net::SFTP.start('200.41.57.106', 'youruser', :password => '$yourpaswword') 
     data = sftp.download!("/entrada/" + name_of_txt_file).split(/\r\n/)
     assert_equal data, ["412;5491920;hola k ase\n416;8605522;hola k ase\n"]
   end
end