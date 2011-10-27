class SessionsController < ApplicationController
  def new
  end

  def create
    token = Api::Authentication.valid_password?(params[:username], params[:password])
    if token.blank?
      redirect_to new_session_path, :alert => "Invalid credentials."
    else
      session[:token] = token
      redirect_to dashboard_path, :notice => "Welcome in, my friend!"
    end
  end

  def destroy
    session.delete(:token)
    redirect_to new_session_url, :notice => "Bye-bye! See you later."
  end
end
