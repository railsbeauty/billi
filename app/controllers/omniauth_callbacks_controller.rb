 class OmniauthCallbacksController < Devise::OmniauthCallbacksController

 def all
    auth = env["omniauth.auth"]
    #Rails.logger.info("auth is **************** #{auth.to_yaml}")
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"],current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.twitter_uid"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all 
end