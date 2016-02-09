class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    temp = [:first_name, :last_name, :email, :password, :password_confirmation]
    temp.each { |p| devise_parameter_sanitizer.for(:sign_up) << p }
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.try(:is_admin?)
  end
end
