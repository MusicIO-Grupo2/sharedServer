var log4js = require('log4js');
var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var cors = require('cors');  
var authCtrl = require('./lib/auth');
var middleware = require('./lib/middleware');
var env = require('node-env-file');
var app = express();
env(__dirname + '/process.env');

app.set('port', (process.env.PORT || 5000));
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json())
app.use(express.static(__dirname + '/public'));
app.use(cors());  

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

var logger = log4js.getLogger("App");
app.use(log4js.connectLogger(log4js.getLogger("consola"), { level: 'auto' }));

// *** routes *** //
var routes = require('./routes/index.js');

// *** main routes *** //
app.use('/', routes);


/// Catch cono 404 para los errores.
/*app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});*/
/*app.use(function(err, req, res, next) {
    logger.error("Se produjo un error:", err);
    res.status(err.status || 500);
    res.json({ error: err.message, trace: err.stack});
});
//Por ahora no renderizamos vista sino que mandamos json con error.
/*    res.render('error', {
        message: '',
        error: err
    });*/






module.exports = app;
