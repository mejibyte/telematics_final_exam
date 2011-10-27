#encoding: utf-8
class Schedule
  XML_BUILDER_OPTIONS = { :root => "pa", :skip_types => true }
  
  def self.xml_for_course_schedule(current_teacher, course_id, group, semester)
    unless current_teacher.has_access_to_course?(course_id)
      return { :curso => { :status => "error", :mensaje => "#{current_teacher.name} no es un profesor de este curso." } }.to_xml(XML_BUILDER_OPTIONS)            
    end
    
    unless group.present?
      return { :curso => { :status => "error", :mensaje => "No se especificó el parámetro 'group'." } }.to_xml(XML_BUILDER_OPTIONS)
    end
    
    unless semester.present?
      return { :curso => { :status => "error", :mensaje => "No se especificó el parámetro 'semester'." } }.to_xml(XML_BUILDER_OPTIONS)
    end    
    
    exams = read_hash.select { |s| s["codigo"] == course_id and s["grupo"] == group }.first || { "evaluacion" => [] }
    exams = exams["evaluacion"].select { |e|  is_on_semester?(e["fecha"], semester) }
    
    { :programacion => { :codigo => course_id, :grupo => group, :evaluacion => RootlessArray.new(exams) } }.to_xml(XML_BUILDER_OPTIONS)
  end
    
  private
  
  def self.is_on_semester?(date, semester)
    d = Date.parse(date)
    year, semester = semester[0..3], semester[-1..-1]
    month = (semester.to_i - 1) * 6 + 1
    first_day_of_semester = Date.parse("#{year}-#{month}-01")
    first_day_of_semester <= d and d <= first_day_of_semester + 6.months
  end
  
  def self.read_hash
    hash = Hash.from_xml(File.read(Rails.root.join("xml/pa/evaluacioncursos.xml")))["pa"]["programacion"]
  end
end