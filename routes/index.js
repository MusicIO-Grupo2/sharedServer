var express = require('express');
var authCtrl = require('../lib/auth');
var middleware = require('../lib/middleware');
var models = require('../models/index');
var functionsDatabase = require('../lib/postgres');


var UserRouter = express.Router();
// Rutas de autenticación y login
UserRouter.post('/auth/login', authCtrl.emailLogin);

// Ruta solo accesible si estás autenticado
UserRouter.get('/private/',middleware.ensureAuthenticated, function(req, res) {} );

UserRouter.get('/', function(req, res) { 
    res.status = 200;
    res.render('index');
});

UserRouter.get('/users/Registrado/',functionsDatabase.getUser,  function(req, res,next) {});
UserRouter.post('/users/Registrar/',functionsDatabase.registerUser,  function(req, res,next) {});
UserRouter.delete('/users/Eliminar/:id',functionsDatabase.deleteUser,  function(req, res,next) {});
UserRouter.delete('/users/Eliminar/',functionsDatabase.deleteUserByMail,  function(req, res,next) {});
UserRouter.put('/users/Actualizar/:id',functionsDatabase.updateUser,  function(req, res,next) {});
UserRouter.put('/users/Reactivar/:id',functionsDatabase.reactivarUser,  function(req, res,next) {});

module.exports = UserRouter;
