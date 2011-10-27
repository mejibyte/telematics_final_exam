class Api::Student < Api::Base

  def self.all(token, course_id, group)
    return [] if token.blank? or course_id.blank? or group.blank?
    request = get("/ei/courses/#{course_id}/students", :query => { :token => token, :group => group })
    request["ei"]["curso"]["estudiante"]
  end
end