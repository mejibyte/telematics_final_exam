#encoding: utf-8
class Course
  XML_BUILDER_OPTIONS = { :root => "ei", :skip_types => true }
  
  def self.xml_for_single_course(current_teacher, id)
    course = read_hash.select { |c| c["codigo"] == id }.first
    course = nil unless current_teacher.has_access_to_course?(course["codigo"])
    if course.blank?
      { :curso => { :status => "error", :mensaje => "No existe un curso con el código '#{id}' o #{current_teacher.name} no es un profesor de este curso." } }.to_xml(XML_BUILDER_OPTIONS)
    else
      course["modulos"] = RootlessArray.new(course.delete("modulo"))
      {:curso => course }.to_xml(XML_BUILDER_OPTIONS)
    end
  end
  
  def self.xml_for_all_courses(current_teacher)
    courses = read_hash.map do |c| 
      { :codigo => c["codigo"], :nombre => c["nombre"], :grupo => groups_for_course(c["codigo"]) } if current_teacher.has_access_to_course?(c["codigo"])
    end.compact
    { :cursos => courses }.to_xml(XML_BUILDER_OPTIONS)
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