class Rtedexis::SFTP::Response
	attr_accessor :invalid_numbers
	def initialize(args = {})
		@invalid_numbers = args[:invalid_numbers]
	end
end