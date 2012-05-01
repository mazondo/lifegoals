require 'rails_autolink'
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_user
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_user
    unless current_user
      redirect_to login_path, :flash => {:error => "Only logged in users can access that page"}
      return
    end
  end
  helper_method :current_user

end
