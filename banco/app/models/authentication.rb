class Authentication
  def self.token_from_credentials(username, password)
    if username.present? and password.present?
      users = Hash.from_xml(File.read(Rails.root.join("xml/users.xml")))["users"]["user"]
      user = users.select { |u| u["username"] == username }.first
      token = user["token"] if user and user["password"] == password
    end
  end
end