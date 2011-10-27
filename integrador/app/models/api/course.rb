class Api::Course < Api::Base

  def self.all(token)
    return [] if token.blank?
    request = get("/ei/courses", :query => { :token => token })
    request["ei"]["cursos"]["curso"]
  end
  
  def self.show(token, course_id)
    return nil if token.blank?
    request = get("/ei/courses/#{course_id}", :query => { :token => token })
    request["ei"]["curso"]
  end

  private 

end