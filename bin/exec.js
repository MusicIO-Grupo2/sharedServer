#!/usr/bin/env node
var app = require('../app');


//Vemos si está el directorio y sino lo creamos.
try {
  require('fs').mkdirSync('./log');
} catch (e) {
  if (e.code != 'EEXIST') {
    console.error("No se puede crear el directorio para logs: ", e);
    process.exit(1);
  }
}

var log4js = require('log4js');
log4js.configure('./config/log4js.json');

var log = log4js.getLogger("Inicialización");

app.get('/', function(request, response) {
    var result = 'Aplicación ejecutándose'
    response.send(result);
}).listen(app.get('port'), function() {
    log.info('La aplicación está corriendo en el puerto: ', app.get('port'));
});
