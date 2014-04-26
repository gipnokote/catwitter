class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  private
  
  def respond_with_ajax
    respond_to do |format|
      format.html {}
      format.js   {render layout: false}
    end
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :password)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:real_name, :username, :password, :password_confirmation)
    end
  end

end
