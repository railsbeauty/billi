 class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all 
   user = User.from_omniauth(request.env["omniauth.auth"])
   if user.persisted?
      sign_in_and_redirect @user, :event => :authentication
   else
    session["devise.user_attributes"] = user.attributes
    redirect_to new_user_registeration_path
   end
  end
  alias_method :twitter, :all 
end
