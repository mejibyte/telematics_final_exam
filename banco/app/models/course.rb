class Course
  def self.xml_for_single_course(id)
    
  end
  
  def self.xml_for_all_courses
    courses = read_hash.map { |c| { :codigo => c["codigo"], :nombre => c["nombre"], :grupo => groups_for_course(c["codigo"]) } }
    { :cursos => courses }.to_xml(:root => "ei", :skip_types => true )
  end
  
  
  private
  
  def self.read_hash
    hash = Hash.from_xml(File.read(Rails.root.join("xml/ei/cursocontenidos.xml")))["ei"]["curso"]
  end
  
  def self.groups_for_course(course_id)
    hash = Hash.from_xml(File.read(Rails.root.join("xml/ei/listaclase.xml")))["ei"]["curso"]
    groups = hash.map do |course|
      course["grupo"] if course["codigo"] == course_id
    end.compact
    RootlessArray.new(groups)
  end
end