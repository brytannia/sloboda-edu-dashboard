class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  skip_before_action :verify_authenticity_token

  def facebook
    generic_callback( 'facebook' )
  end

  def google
    generic_callback( 'google' )
  end

  def github
    generic_callback( 'github' )
  end

  def generic_callback( provider )
    @user = User.from_omniauth(request.env["omniauth.auth"])
     if @user.persisted?
       sign_in_and_redirect @user, event: :authentication
       set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
     else
       session["devise.#{provider}_data"] = env["omniauth.auth"]
       redirect_to new_user_registration_url
     end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end