Banco de datos
==============

Ofrece los servicios en una API REST.

Todos los requests (excepto los de autenticación) deben estar acompañados de un parámetro `token` (por ejemplo, `http://host/ei/courses?token=asdf1234`). Cualquier requests que no tenga el parámetro `token` o tenga un `token` inválido será respondido con:

    <?xml version="1.0" encoding="UTF-8"?>
    <error>
      <mensaje>Token inválido</mensaje>
    </error>

En adelante se excluye el parámetro `token` de todos los ejemplos, por simplicidad.

Eafit Interactiva
-----------------

* `String login(String username, String password)`

  Implementado en `POST http://host/ei/session`

  **Ejemplo:**
      `curl -d username=amejiap3 -d password=asdf http://localhost:3001/ei/session`

  Respuesta:

    <?xml version="1.0" encoding="UTF-8"?>
    <ei>
      <autenticacion>
        <status>ok</status>
        <token>r4nd0mn3ss</token>
      </autenticacion>
    </ei>
    

 `curl -d username=amejiap3 -d password=invalid http://localhost:3001/ei/session`

    <?xml version="1.0" encoding="UTF-8"?>
    <ei>
      <autenticacion>
        <status>error</status>
        <token nil="true"></token>
      </autenticacion>
    </ei>


* `String getCursos(String token)`

 Implementado en `GET http://host/ei/courses`
 
 **Ejemplo:**
 
 `curl http://localhost:3001/ei/courses`
 
 Respuesta:
 
    <?xml version="1.0" encoding="UTF-8"?>
    <ei>
      <cursos>
        <curso>
          <codigo>st0263</codigo>
          <nombre>Topicos Especiales en Telematica</nombre>
          <grupo>031</grupo>
        </curso>
        <curso>
          <codigo>st0260</codigo>
          <nombre>Seminario de Ingeniería de Sistemas</nombre>
          <grupo>032</grupo>
        </curso>
      </cursos>
    </ei>
 
 
* `String getContenidosCursos(String token, String cursoId)`

  Implementado en `GET http://host/ei/courses/:id`. (`:id` debe reemplazarse por el código del curso)
  
  **Ejemplo:**
  
  `curl http://localhost:3001/ei/courses/st0263`
  
  Respuesta:
  
    <?xml version="1.0" encoding="UTF-8"?>
    <ei>
      <curso>
        <codigo>st0263</codigo>
        <nombre>Topicos Especiales en Telematica</nombre>
        <modulo>
          <titulo>Presentación de Cliente/Servidor</titulo>
          <descripcion>en esta presentación se dan los conceptos fundamentales en la arquitectura c/s</descripcion>
          <url>http://interactiva.eafit.edu.co/we2345kjjka/link1</url>
        </modulo>
        <modulo>
          <titulo>Presentación de P2P</titulo>
          <descripcion>en esta presentación se dan los conceptos fundamentales en la arquitectura p2p </descripcion>
          <url>http://interactiva.eafit.edu.co/we2345kjjka/link2</url>
        </modulo>
      </curso>
    </ei>
  
  
`curl http://localhost:3001/ei/courses/st0666`
    
    <?xml version="1.0" encoding="UTF-8"?>
    <ei>
      <curso>
        <status>error</status>
        <mensaje>No existe un curso con el código 'st0666' o Edwin Montoya no es un profesor de este curso.</mensaje>
      </curso>
    </ei>
  
* `String getListaClase(String token, String cursoId, String grupo)`

  Implementado en `GET http://host/ei/courses/:course_id/students?group=:group_id`. (`:course_id` debe reemplazarse por el código del curso y `:group_id` debe reemplazarse por el grupo).
  
  **Ejemplo:** `curl http://localhost:3001/ei/courses/st0263/students?group=031`
  
  Respuesta:
  
    <?xml version="1.0" encoding="UTF-8"?>
    <ei>
      <curso>
        <codigo>st0263</codigo>
        <grupo>031</grupo>
        <estudiante>
          <codigo>200910009010</codigo>
          <nombre>Juan Esteban Perez</nombre>
        </estudiante>
        <estudiante>
          <codigo>201010008010</codigo>
          <nombre>Luis Javier Henao</nombre>
        </estudiante>
      </curso>
    </ei>

  Con un token de un profesor que no tenga acceso a la materia:
  
  `curl http://localhost:3001/ei/courses/st0263/students?group=031&token=123hhdj`

    <?xml version="1.0" encoding="UTF-8"?>
    <ei>
      <curso>
        <status>error</status>
        <mensaje>Juan Carlos Montoya no es un profesor de este curso.</mensaje>
      </curso>
    </ei>

Programación Académica
-----------------

* `String login(String username, String password)`

 Exactamente igual al login en EAFIT Interactiva, sólo que la dirección es `POST http://host/pa/session`.
    
* `String getProgramacion(String token, String cursoId, String grupo, String semestre)`

 Implementado en `GET http://host/pa/courses/:course_id/schedule?group=:group_id&semester=:semester`. (`:course_id` debe reemplazarse por el código del curso, `:group_id` debe reemplazarse por el grupo y `:semester` debe reemplazarse por el semestre. El semestre debe estar en formato "YYYYS" (Año-Semestre), por ejemplo "20101" ó "20112" pero nunca "2010-1" ó "20113").

 **Ejemplo:** 
 `curl 'http://localhost:3001/pa/courses/st0260/schedule?group=032&semester=20112'`

   <?xml version="1.0" encoding="UTF-8"?>
   <pa>
     <programacion>
       <codigo>st0260</codigo>
       <grupo>032</grupo>
       <evaluacion>
         <tipo>parcial</tipo>
         <porcentaje>70</porcentaje>
         <fecha>2011-09-27</fecha>
       </evaluacion>
       <evaluacion>
         <tipo>trabajo</tipo>
         <porcentaje>30</porcentaje>
         <fecha>2011-10-20</fecha>
       </evaluacion>
     </programacion>
   </pa>



Admisiones y Registro
-----------------

* `String login(String username, String password)`

* `String consultaEstudiantesPorNombre(String token, String patronNombre)`

 Implementado en `GET http://host/ar/students/search?name_pattern=:name_pattern`. (`:name_pattern` debe reemplazarse por el patrón del nombre a buscar).


 **Ejemplo:** `curl 'http://localhost:3001/ar/students/search?name_pattern=ju'`

   <?xml version="1.0" encoding="UTF-8"?>
   <ar>
     <estudiante>
       <codigo>200910009010</codigo>
       <nombre>Juan Esteban Perez</nombre>
     </estudiante>
   </ar>


* `String consultaDatosEstudiante(String token, string codEstudiante)`
