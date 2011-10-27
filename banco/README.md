Banco de datos
==============

Ofrece los servicios en una API REST.

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


*
    String getCursos(String token)
    String getContenidosCursos(String token, String cursoId)
    String getListaClase(String token, String cursoId, String grupo)

Programación Académica
-----------------

    String login(String username, String password)
    String getProgramacion(String token, String cursoId, String grupo, String semestre)

Admisiones y Registro
-----------------

    String login(String username, String password)
    String consultaEstudiantesPorNombre(String token, String patronNombre)
    String consultaDatosEstudiante(String token, string codEstudiante)
