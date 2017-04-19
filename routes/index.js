var express = require('express');
var authCtrl = require('../lib/auth');
var middleware = require('../lib/middleware');
var models = require('../models/index');
var functionsDatabase = require('../lib/postgres');


var Router = express.Router();
// Rutas de autenticación y login
Router.post('/auth/login', authCtrl.emailLogin);

// Ruta solo accesible si estás autenticado
Router.get('/private/',middleware.ensureAuthenticated, function(req, res) {} );

Router.get('/', function(req, res) { 
    res.status = 200;
    res.render('index');
});

Router.get('/users/Registrado/',functionsDatabase.getUser,  function(req, res,next) {});
Router.get('/users/Contactos/:id',functionsDatabase.listarContactosUser,  function(req, res,next) {});
Router.post('/users/Registrar/',functionsDatabase.registerUser,  function(req, res,next) {});
Router.delete('/users/Eliminar/:id',functionsDatabase.deleteUser,  function(req, res,next) {});
Router.delete('/users/Eliminar/',functionsDatabase.deleteUserByMail,  function(req, res,next) {});
Router.put('/users/Actualizar/:id',functionsDatabase.updateUser,  function(req, res,next) {});
Router.put('/users/Reactivar/:id',functionsDatabase.reactivarUser,  function(req, res,next) {});

Router.get('/canciones/ObtenerCanciones/',functionsDatabase.getCanciones,  function(req, res,next) {});
Router.get('/canciones/ObtenerCancion/:id',functionsDatabase.getCancion,  function(req, res,next) {});
Router.post('/canciones/AltaCancion/',functionsDatabase.altaCancion,  function(req, res,next) {});
Router.delete('/canciones/BajaCancion/:id',functionsDatabase.bajaCancion,  function(req, res,next) {});
Router.put('/canciones/ActualizarCancion/:id',functionsDatabase.actualizarCancion,  function(req, res,next) {});
Router.put('/canciones/ReactivarCancion/:id',functionsDatabase.reactivarCancion,  function(req, res,next) {});
Router.post('/canciones/AltaGeneroCancion/',functionsDatabase.altaGeneroCancion,  function(req, res,next) {});
Router.delete('/canciones/BajaGeneroCancion/',functionsDatabase.bajaGeneroCancion,  function(req, res,next) {});
Router.post('/canciones/PuntuarCancion/',functionsDatabase.puntuarCancion,  function(req, res,next) {});
Router.post('/canciones/MarcarCancion/',functionsDatabase.marcarCancion,  function(req, res,next) {});
Router.post('/canciones/DesmarcarCancion/',functionsDatabase.desmarcarCancion,  function(req, res,next) {}); //La hacemos por post porque usamos el body.
Router.get('/canciones/ObtenerPuntuacionCancion/:id',functionsDatabase.obtenerPuntuacionCancion,  function(req, res,next) {});


module.exports = Router;
