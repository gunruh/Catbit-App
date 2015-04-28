class SessionsController < ApplicationController
  def new
  end

  def create
  	auth_hash = request.env['omniauth.auth']
	
	@authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	if @authorization
                user = @authorization.user
                user.token = auth_hash["credentials"]["token"]
		user.secret = auth_hash["credentials"]["secret"]
		user.save

	else
		user = User.new :name => auth_hash["info"]["name"] #, :email => auth_hash["user_info"]["email"]
		user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
                user.token = auth_hash["credentials"]["token"]
		user.secret = auth_hash["credentials"]["secret"]
		user.save
	end
        session[:user_id] = user.id
        redirect_to page_home_path
	#render :text => user.fitbitClient.activities_on_date('today')
  end

  def failure
	render :text => "Sorry, but you didn't allow access to our app!"
  end

  def destroy
	session[:user_id] = nil
	render :text => "You've logged out!"
  end
end
