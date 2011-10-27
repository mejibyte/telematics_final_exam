class Teacher
  attr_accessor :username, :name
  
  def initialize(attributes = {})
    attributes.symbolize_keys!
    self.username = attributes[:username]
    self.name = attributes[:name]
  end
  
  def has_access_to_course?(course_id)
    hash = Hash.from_xml(File.read(Rails.root.join("xml/ei/profesorcursos.xml")))["ei"]["profesor"]
    me = hash.select { |h| h["username"] == self.username }.compact.first
    return false if me.blank?
    courses = me["cursos"]["curso"]
    courses = [courses] unless courses.is_a?(Array)
    courses.map { |c| c["codigo"] }.include?(course_id)
  end
end