Shared Server - MusicIO Grupo 2- Taller de Programación II - FIUBA

Estructura de directorios:
- bin
	- exec.js: file que contiene comandos para ejecutar lo que se encuentra en app.js y ponerse a escuchar en un puerto determinado peticiones.
- init_scripts
	- Scripts de inicio para la base.
- lib
	- Carpeta con librerias varias: password, token, servicios, etc.

- Migrations
	- Carpeta que contiene las migrations de sequelize de cambio de base de datos.
- Models
	- Carpeta que contiene los modelos generados por sequelize
- node_modules
	- Carpeta con los módulos instalados de node.
- routes
	- Archivo donde se define los servicios de la API Rest.
- test
	- Carpeta con archivo con test suite.

- app.js : Archivo donde tiene la inclusión de dependencias y del routes.
- docker-compose.yml: Archivo para configurar el build de docker.
- Dockerfile: Define que hacer al momento de levantar la máquina de docker para la parte de node.
- process.env: Variables de entorno.
- Procfile: Usado por Heroku para levantar.
- restore.sh: Comando para realizar un dump sobre la carpeta de init (por si se cambia la base)
- sequelizerc: Config para sequelize, donde indica paths de los componentes que utiliza.
- travis.yml: Archivo de configuración para travis.

Ejemplos de prueba con Curl:

Saber si un usuario está registrado por mail:	curl -i http://localhost:5000/user/Registrado?email='nflabo'
Saber si un usuario está registrado por id: 	curl -i http://localhost:5000/user/Registrado?id=1
Auth Login: curl -H "Content-Type: application/json" -X POST -d '{"Email":"nflabo","Password":"xyz"}' http://localhost:5000/auth/login

Docker:
	- https://cloud.docker.com/swarm/tallermusiciogrupo2
	- tallermusiciogrupo2 (user)
	- nflabo@gmail.com (passwd pedirlo)
	- docker pull tallermusiciogrupo2/sharedserver_app. 
		Una vez descargada la imagen, en la carpeta actual se debe tener la carpeta de init_scripts.
		Por otro lado, se dejó expuesto el postgres en el puerto 8080 para poder trabajar con postgres.

Heroku Server:
	Servidor: https://musiciogrupo2.herokuapp.com/
	Git: https://git.heroku.com/musiciogrupo2.git	
	DB: https://data.heroku.com/datastore/218034bf-a1c7-4ae5-b081-4fe1a9071d21
	Heroku pull database: 
		- Cambiar primero de usuario: sudo su postgres
		- heroku pg:pull postgresql-graceful-40196 musicio2 --app musiciogrupo2

	Heroku push database:
		- heroku pg:reset
		- heroku pg:push musicio2 postgresql-graceful-40196 --app musiciogrupo2

Referencias:

	- Docker: 
		https://docs.docker.com/compose/compose-file/#volume-configuration-reference

		https://docs.docker.com/engine/getstarted/step_six/#step-2-pull-your-new-image

		https://docs.docker.com/engine/reference/commandline/tag/ 
	- Heroku:
		https://devcenter.heroku.com/articles/getting-started-with-nodejs#introduction
		https://devcenter.heroku.com/articles/how-heroku-works
	- Mocha
		https://mochajs.org/
	- Chai
		http://chaijs.com/



Travis : 
[![Build Status](https://travis-ci.org/MusicIO-Grupo2/sharedServer.svg?branch=master)](https://travis-ci.org/MusicIO-Grupo2/sharedServer)
