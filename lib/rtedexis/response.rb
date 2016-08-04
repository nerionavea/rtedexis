class Rtedexis::SFTP::Response
	attr_accessor :invalid_numbers, :messages_sended
	def initialize(args = {})
		@invalid_numbers = args[:invalid_numbers]
		@messages_sended = args[:messages_sended]
	end
end