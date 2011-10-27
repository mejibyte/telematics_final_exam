class Ei::SessionsController < ApplicationController
  def create
    options = { :skip_types => true, :root => "ei" }
    if token = Authentication.token_from_credentials(params[:username], params[:password])
      render :xml => { :autenticacion => { :status => "ok", :token => token } }.to_xml(options)
    else
      render :xml => { :autenticacion => { :status => "error", :token => nil } }.to_xml(options)
    end
  end
end
