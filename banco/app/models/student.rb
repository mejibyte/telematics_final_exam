#encoding: utf-8
class Student
  XML_BUILDER_OPTIONS = { :root => "ei", :skip_types => true }
  
  def self.xml_for_students_on_course(current_teacher, course_id, group)
    unless current_teacher.has_access_to_course?(course_id)
      return { :curso => { :status => "error", :mensaje => "#{current_teacher.name} no es un profesor de este curso." } }.to_xml(XML_BUILDER_OPTIONS)            
    end
    
    unless group.present?
      return { :curso => { :status => "error", :mensaje => "No se especificó el parámetro 'group'." } }.to_xml(XML_BUILDER_OPTIONS)
    end
    
    students = read_hash.map { |c| c["estudiante"] if c["codigo"] == course_id and c["grupo"] == group }.compact.first
    students = [students] unless students.is_a?(Array)

    { :curso => { :codigo => course_id, :grupo => group, :estudiante => RootlessArray.new(students) } }.to_xml(XML_BUILDER_OPTIONS)
  end
    
  private
  
  def self.read_hash
    hash = Hash.from_xml(File.read(Rails.root.join("xml/ei/listaclase.xml")))["ei"]["curso"]
  end
end