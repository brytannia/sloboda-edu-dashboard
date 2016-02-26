class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_vars
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    temp = [:first_name, :last_name, :email, :password, :password_confirmation]
    temp.each { |p| devise_parameter_sanitizer.for(:sign_up) << p }
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.try(:admin?)
  end

  def set_vars
    unless current_user.nil?
      gon.push(
        current_users: users_path,
        current_profile: user_path(current_user)
      )
    end
  end
end
