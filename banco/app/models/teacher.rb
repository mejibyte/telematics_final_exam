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
  
  
  def has_access_to_student?(code)
    hash = Hash.from_xml(File.read(Rails.root.join("xml/ei/profesorcursos.xml")))["ei"]["profesor"]
    me = hash.select { |h| h["username"] == self.username }.compact.first
    return false if me.blank?
        
    courses = me["cursos"]["curso"]
    courses = [courses] unless courses.is_a?(Array)
    my_courses_and_groups = courses.map { |c| [c["codigo"], c["grupo"]] }
    
    courses = Hash.from_xml(File.read(Rails.root.join("xml/ei/listaclase.xml")))["ei"]["curso"]
    courses.each do |course|
      next unless my_courses_and_groups.include?([ course["codigo"], course["grupo"] ])
      student_codes = course["estudiante"].map { |e| e["codigo"] }
      return true if student_codes.include?(code)
    end
    return false
  end

end
# 
# <?xml version="1.0" encoding="UTF-8"?>
# <ar>
#     <estudiante>
#         <codigo>200910009010</codigo>
#         <nombre>Juan Esteban Perez</nombre>
#         <email>jperez@eafit.edu.co</email>
#         <telefono>311-14-23</telefono>
#         <cursos>
#             <curso>
#                 <codigo>st0263</codigo>
#                 <nombre>tópicos especiales en telemática</nombre>
#                 <grupo>031</grupo>
#             </curso>
#             <curso>
#                 <codigo>st0278</codigo>
#                 <nombre>computación gráfica</nombre>
#                 <grupo>031</grupo>
#             </curso>
#         </cursos>
#     </estudiante>
#     <estudiante>
#         <codigo>201010008010</codigo>
#         <nombre>Luis Javier Henao</nombre>
#         <email>lhenao@eafit.edu.co</email>
#         <telefono>311-34-23</telefono>
#         <cursos>
#             <curso>
#                 <codigo>st0263</codigo>
#                 <nombre>tópicos especiales en telemática</nombre>
#                 <grupo>031</grupo>
#             </curso>
#         </cursos>
#     </estudiante>
#     
#     <estudiante>
#         <codigo>2008127504010</codigo>
#         <nombre>pedro esteban duarte</nombre>
#         <email>pduarte@eafit.edu.co</email>
#         <telefono>311-34-00</telefono>
#         <cursos>
#             <curso>
#                 <codigo>st0260</codigo>
#                 <nombre>Seminario de Ingeniería de Sistemas</nombre>
#                 <grupo>032</grupo>
#             </curso>
#         </cursos>
#     </estudiante>
#     
#     <estudiante>
#         <codigo>201027505010</codigo>
#         <nombre>Luis Javier tirado</nombre>
#         <email>ltirado@eafit.edu.co</email>
#         <telefono>578-34-00</telefono>
#         <cursos>
#             <curso>
#                 <codigo>st0260</codigo>
#                 <nombre>Seminario de Ingeniería de Sistemas</nombre>
#                 <grupo>032</grupo>
#             </curso>
#         </cursos>
#     </estudiante>
#     
#     <estudiante>
#         <codigo>2006127606010</codigo>
#         <nombre>juan camilo vargas</nombre>
#         <email>jvargas@eafit.edu.co</email>
#         <telefono>345-34-78</telefono>
#         <cursos>
#             <curso>
#                 <codigo>st0255</codigo>
#                 <nombre>telematica</nombre>
#                 <grupo>031</grupo>
#             </curso>
#         </cursos>
#     </estudiante>
#     
#     <estudiante>
#         <codigo>200627509010</codigo>
#         <nombre>monica correa</nombre>
#         <email>mcorrea@eafit.edu.co</email>
#         <telefono>345-77-78</telefono>
#         <cursos>
#             <curso>
#                 <codigo>st0255</codigo>
#                 <nombre>telematica</nombre>
#                 <grupo>031</grupo>
#             </curso>
#         </cursos>
#     </estudiante>
#     
#     <estudiante>
#         <codigo>201127509010</codigo>
#         <nombre>blanca zuluaga</nombre>
#         <email>bzuluaga@eafit.edu.co</email>
#         <telefono>345-77-78</telefono>
#         <cursos>
#             <curso>
#                 <codigo>st0910</codigo>
#                 <nombre>redes LANs</nombre>
#                 <grupo>032</grupo>
#             </curso>
#         </cursos>
#     </estudiante>
#     
#     <estudiante>
#         <codigo>201127808010</codigo>
#         <nombre>pedro martinez</nombre>
#         <email>pmartinez@eafit.edu.co</email>
#         <telefono>555-77-78</telefono>
#         <cursos>
#             <curso>
#                 <codigo>st0910</codigo>
#                 <nombre>redes LANs</nombre>
#                 <grupo>032</grupo>
#             </curso>
#             <curso>
#                 <codigo>st0278</codigo>
#                 <nombre>computacion grafica</nombre>
#                 <grupo>031</grupo>
#             </curso>
#         </cursos>
#     </estudiante>
#     
#     <estudiante>
#         <codigo>200910009010</codigo>
#         <nombre>Juan Esteban Perez</nombre>
#         <email>jeperez@eafit.edu.co</email>
#         <telefono>555-77-00</telefono>
#         <cursos>
#             <curso>
#                 <codigo>st0278</codigo>
#                 <nombre>computacion grafica</nombre>
#                 <grupo>031</grupo>
#             </curso>
#         </cursos>
#     </estudiante>
#     
#     <estudiante>
#         <codigo>200245600910</codigo>
#         <nombre>esteban martinez</nombre>
#         <email>emartinez@eafit.edu.co</email>
#         <telefono>666-77-00</telefono>
#         <cursos>
#             <curso>
#                 <codigo>st0278</codigo>
#                 <nombre>computacion grafica</nombre>
#                 <grupo>031</grupo>
#             </curso>
#         </cursos>
#     </estudiante>
#     
# </ar>
# 
