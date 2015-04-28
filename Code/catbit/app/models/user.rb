class User < ActiveRecord::Base

	has_many :authorizations
	validates :name, :presence => true

	def fitbitClient
		@client ||= Fitgem::Client.new({
			consumer_key: '3fc8ca4d052045179285308aadb129c1',
			consumer_secret: '1d57103e84b74a2e8d94726bf5147c0d',
			token: token,
			secret: secret
		})
	end
end
