var express = require('express');
var authCtrl = require('../auth');
var middleware = require('../middleware');
var models = require('../models/index');
var functionsDatabase = require('../lib/postgres');


var UserRouter = express.Router();
// Rutas de autenticación y login
UserRouter.post('/auth/login', authCtrl.emailLogin);

// Ruta solo accesible si estás autenticado
UserRouter.get('/private',middleware.ensureAuthenticated, function(req, res) {} );

UserRouter.get('/', function(req, res) { });

UserRouter.get('/Registrado/',functionsDatabase.getUser,  function(req, res,next) {});

module.exports = UserRouter;
