class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_token, :logged_in?
    
  protected

  def current_token
    session[:token]
  end
  
  def logged_in?
    current_token.present?
  end
  
  def require_user
    redirect_to new_session_path, :notice => "You need to log in first" unless logged_in?
  end
  

end
