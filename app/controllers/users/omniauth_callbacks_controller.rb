class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
      @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
      
    if @user.persisted?
      flash[:notiche] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
    if request.env["omniauth.auth"].info.email.blank?
      redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
    end
  end

end