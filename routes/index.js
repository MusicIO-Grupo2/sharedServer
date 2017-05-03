var express = require('express');
var authCtrl = require('../lib/auth');
var middleware = require('../lib/middleware');
var models = require('../models/index');
var functionsDatabase = require('../lib/postgres');


var Router = express.Router();
// Rutas de autenticación y login
Router.post('/token/', authCtrl.emailLogin);

// Ruta solo accesible si estás autenticado
Router.get('/private/',middleware.ensureAuthenticated, function(req, res) {} );

Router.get('/', function(req, res) { 
    res.status = 200;
    res.render('index');
});

Router.get('/users/',functionsDatabase.getUsers,  function(req, res,next) {});
Router.get('/users/mail/:mail',functionsDatabase.getUserByMail,  function(req, res,next) {});
Router.get('/users/me/contacts/',functionsDatabase.listarContactosUser,  function(req, res,next) {});
Router.get('/users/me/',functionsDatabase.getUserMe,  function(req, res,next) {});
Router.post('/users/',functionsDatabase.registerUser,  function(req, res,next) {});
Router.delete('/users/:id',functionsDatabase.deleteUser,  function(req, res,next) {});
Router.delete('/users/mail/:mail',functionsDatabase.deleteUserByMail,  function(req, res,next) {});
Router.put('/users/:id',functionsDatabase.updateUser,  function(req, res,next) {});
Router.put('/users/me/photo/',functionsDatabase.updateFotoPerfil,  function(req, res,next) {});
Router.put('/users/Reactivar/:id',functionsDatabase.reactivarUser,  function(req, res,next) {});


Router.get('/tracks/',functionsDatabase.getCanciones,  function(req, res,next) {});
Router.get('/tracks/paginate/',functionsDatabase.getCancionesPaginadas,  function(req, res,next) {});
Router.get('/tracks/:id',functionsDatabase.getCancion,  function(req, res,next) {});
Router.post('/tracks/',functionsDatabase.altaCancion,  function(req, res,next) {});
Router.delete('/tracks/:id',functionsDatabase.bajaCancion,  function(req, res,next) {});
Router.put('/tracks/:id',functionsDatabase.actualizarCancion,  function(req, res,next) {});
Router.put('/tracks/ReactivarCancion/:id',functionsDatabase.reactivarCancion,  function(req, res,next) {});
Router.post('/tracks/:id/genero/:generoid/',functionsDatabase.altaGeneroCancion,  function(req, res,next) {});
Router.delete('/tracks/:id/genero/:generoid/',functionsDatabase.bajaGeneroCancion,  function(req, res,next) {});
Router.post('/tracks/:id/popularity',functionsDatabase.puntuarCancion,  function(req, res,next) {});
Router.post('/tracks/:id/like',functionsDatabase.marcarCancion,  function(req, res,next) {});
Router.post('/tracks/:id/unlike',functionsDatabase.desmarcarCancion,  function(req, res,next) {}); //La hacemos por post porque usamos el body.
Router.get('/tracks/ObtenerPuntuacionCancion/:id',functionsDatabase.obtenerPuntuacionCancion,  function(req, res,next) {});


module.exports = Router;
