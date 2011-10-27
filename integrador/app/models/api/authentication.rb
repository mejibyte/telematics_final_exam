class Api::Authentication < Api::Base

  def self.valid_password?(username, password)
    return false if username.blank? or password.blank?
    request = post("/ei/session", :body => { :username => username, :password => password })
    puts request
    status = request["ei"]["autenticacion"]["status"]
    return false if status != "ok"
    request["ei"]["autenticacion"]["token"]
  end

  private 

end