class ApplicationController < ActionController::Base
  # Checkpoint #39 - Authorization
  include Pundit
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Checkpoint #37 - Authentication Continued
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # Checkpoint #39 - Authorization
  # When the exception [from posts_controller.new] (a
  # 'Pundit::NotAuthorizedError') is thrown, Rails halts whatever is being
  # executed, this ensuring the action isn't rendered. But, this will also
  # break the user flow as Rails will render an application error page. To
  # handle this, making the restriction as user friendly as possible, we add
  # this 'rescue_from' block here.
  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end
  
  # Checkpoint #37 - Authentication Continued
  protected
  
  # Checkpoint #37 - Authentication Continued
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end