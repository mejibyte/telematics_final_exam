Examen Final de Tópicos Avanzados en Telemática - Andrés Mejía
==============================================================

Alcance del proyecto
--------------------

* Servicio web que ofrece las APIs requeridas
* Aplicación web que consume los datos expuestos por el servicio web

Ejecución
---------

El proyecto está desplegado en `sistemas.eafit.edu.co`. Para llegar a él, se puede ejecutar:

    ssh amejiap3@sistemas.eafit.edu.co
    cd /home/est/amejiap3/examen

Para ver el proyecto funcionando, hay que ejecutar las 2 partes: el banco de datos (la aplicación que ofrece el servicio web) y el integrador (la aplicación web que consume los datos).

Lo primero es ejecutar el banco de datos. Se puede ejecutar en cualquier servidor y puerto, pero se recomienda el puerto 3001 de `localhost` porque es el que está configurado por defecto en el integrador. Para ejecutar el banco se usan estos comandos:

    cd banco
    rails s -p 3001
    
A continuación, hay que ejecutar el integrador. Si el banco está corriendo en un host diferente a `localhost:3001`, hay que configurar el nuevo host editando el archivo `config/app_config.yml`:

    cd integrador
    nano config/app_config.yml # Cambiar la línea que dice data_source_url y poner el nuevo host

Una vez se haya configurado la ruta del banco, simplemente se ejecuta el integrador con:

    rails s -p 3000 # O cualquier otro puerto

En seguida se accede desde el navegador a `localhost:3000`, ¡y listo! Se debería ver un formulario de autenticación para comenzar a usar la aplicación.


Los archivos XML utilizados por el banco se encuentran en `banco/xml`, en caso de que se deseen modificar para hacer pruebas.
