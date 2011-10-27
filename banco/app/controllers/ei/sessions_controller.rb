class Ei::SessionsController < ApplicationController
  def create
    options = { :skip_types => true, :root => "ei" }
    if token = valid_credentials?(params[:username], params[:password])
      render :xml => { :autenticacion => { :status => "ok", :token => token } }.to_xml(options)
    else
      render :xml => { :autenticacion => { :status => "error", :token => nil } }.to_xml(options)
    end
  end
  
  private
  
  def valid_credentials?(username, password)
    if username.present? and password.present?
      users = Hash.from_xml(File.read(Rails.root.join("xml/users.xml")))["users"]["user"]
      user = users.select { |u| u["username"] == username }.first
      token = user["token"] if user and user["password"] == password
    end
  end
end
