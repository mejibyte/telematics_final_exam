Banco de datos
==============

Ofrece los servicios en una API REST.

Eafit Interactiva
-----------------

    String login(String username, String password)
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
