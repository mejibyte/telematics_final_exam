class Authentication
  def self.token_from_credentials(username, password)
    if username.present? and password.present?
      user = read_hash.select { |u| u["username"] == username }.first
      token = user["token"] if user and user["password"] == password
    end
  end
  
  def self.valid_token?(some_token)
    read_hash.map { |u| u["token"] }.compact.include?(some_token)
  end
  
  def self.teacher_for_token(some_token)
    attributes = read_hash.map { |u| u if u["token"] == some_token }.compact.first
    Teacher.new(attributes)
  end
  
  private
  
  def self.read_hash
    users = Hash.from_xml(File.read(Rails.root.join("xml/users.xml")))["users"]["user"]
  end
end