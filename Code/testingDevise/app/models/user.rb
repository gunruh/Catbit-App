class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :omniauthable, :omniauth_providers => [:fitbit]

  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	        user.provider = auth.provider
		user.uid = auth.uid
		user.email = auth.info.email
		user.oauth_token = auth['credentials']['token']
		user.oauth_secret = auth['credentials']['secret']
		#user.password = Devise.friendly_token[0,20]
	end

	if current_user.oauth_token != auth['credentials']['token'] && current_user.oauth_secret != auth['credentials']['secret']
	current_user.oauth_token = auth['credentials']['token']
	current_user.oauth_secret = auth['credentials']['secret']
	current_user.save
	end

  end

  def fitbit_data
  raise "Account is not linked with a Fitbit account" unless linked?
  @client ||= Fitgem::Client.new(
  	:conumer_key => ENV["FITBIT_CONSUMER_KEY"],
	:consumer_secret => ENV["FITBIT_CONSUMER_SECRET"],
	:token => oauth_token,
	:secret => oauth_secret,
	:user_id => uid,
	)
  end

end
