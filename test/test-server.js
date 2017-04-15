var chai = require('chai');
var chaiHttp = require('chai-http');
var server = require('../app');
var helperToken = require('../lib/service');
var should = chai.should();

chai.use(chaiHttp);

describe('Tokens', function() {
	it('Obtener Token by mail y password', function(done) {
	       chai.request(server)
	      .get('/users/Registrado?email=nflabo@gmail.com')
	      .end(function(err, res){
		res.should.have.status(200);
		res.should.be.json;
		res.body.should.have.property('Name');
		    res.body.Name.should.equal('Nicolas');
		    res.body.LastName.should.equal('Fernandez');

		done();
	      });
	   });
	it('Test Token NO OK', function(done) {
	       chai.request(server)
	      .get('/private/')
	      .end(function(err, res){
		res.should.have.status(401);
		res.should.be.json;
		done();
	      });
	   });
	it('Test Token expirado', function(done) {
	   chai.request(server)
		.get('/private/')
		.set('authorization', 'test ' + 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEwLCJpYXQiOjE0OTIyODc5NTAsImV4cCI6MTQ5MjI4Nzk1MH0.kNRiDUt-LJ6bVc81sSgCVdPxeIwiZceJRswlAjstSbo')
		.end(function(err, res){
		res.should.have.status(401);
		res.should.be.json;
		done();
	      });
	   });
	it('Test Token NO expirado', function(done) {
	   var tokenGenerado= helperToken.createToken(10);
	   chai.request(server)
		.get('/private/')
		.set('authorization', 'test ' + tokenGenerado)
		.end(function(err, res){
		res.should.have.status(200);
		res.should.be.json;
		done();
	      });
	   });
});

describe('Users', function() {
  
  it('Obtener Usuario Registrado by email', function(done) {
       chai.request(server)
      .post('/auth/login/')
      .send({"Email":"marcospernica@yahoo.com.ar","Password":"test"})
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
        done();
      });
   });
  it('Error al autenticar Usuario Registrado by email', function(done) {
       chai.request(server)
      .post('/auth/login/')
      .send({"Email":"marcospernica@yahoo.com","Password":"test"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
  it('Error al autenticar Usuario password Registrado by email', function(done) {
       chai.request(server)
      .post('/auth/login/')
      .send({"Email":"marcospernica@yahoo.com.ar","Password":"testmal"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
  it('Obtener Usuario Registrado by id', function(done) {
       chai.request(server)
      .get('/users/Registrado?id=11')
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('Name');
            res.body.Name.should.equal('Nicolas');
            res.body.LastName.should.equal('Fernandez');

        done();
      });
   });
   it('Obtener Usuario Registrado by id no encontrado', function(done) {
       chai.request(server)
      .get('/users/Registrado?id=0')
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
   it('Eliminar Usuario by Mail', function(done) {
       chai.request(server)
      .delete('/users/Eliminar?Email=testtaller2@taller2.com')
      .end(function(err, res){
        res.should.be.json;
        done();
      });
   });
   it('Eliminar Usuario by Mail', function(done) {
       chai.request(server)
      .delete('/users/Eliminar?Email=inexistente')
      .end(function(err, res){
        res.should.be.json;
        done();
      });
   });
   it('Registrar Usuario', function(done) {
       chai.request(server)
      .post('/users/Registrar/')
      .send({"Email":"testtaller2@taller2.com","Password":"test","Nombre":"taller","Apellido":"taller","FechaNacimiento":"1991-01-01"})
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
        res.body.user.Name.should.equal('taller');
       done();
      });
   });
   it('Registrar Usuario Registrado', function(done) {
       chai.request(server)
      .post('/users/Registrar/')
      .send({"Email":"testtaller2@taller2.com","Password":"test","Nombre":"taller","Apellido":"taller","FechaNacimiento":"1991-01-01"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
   it('Actualizar Usuario by id', function(done) {
       chai.request(server)
      .put('/users/Actualizar/11')
      .send({"Email":"nflabo@gmail.com","Password":"test","Nombre":"Nicolas","Apellido":"Fernandez","FechaNacimiento":"1991-01-01"})
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
            res.body.user.Name.should.equal('Nicolas');
            res.body.user.LastName.should.equal('Fernandez');

        done();
      });
   });
   it('Actualizar Usuario by id inexistente', function(done) {
       chai.request(server)
      .put('/users/Actualizar/0')
      .send({"Email":"nflabo@gmail.com","Password":"test","Nombre":"Nicolas","Apellido":"Fernandez","FechaNacimiento":"1991-01-01"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
   it('Eliminar Usuario by id', function(done) {
       chai.request(server)
      .delete('/users/Eliminar/10')
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
        res.body.user.UserID.should.equal('10');
        done();
      });
   });
   it('Eliminar Usuario by id inexistente', function(done) {
       chai.request(server)
      .delete('/users/Eliminar/0')
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
   it('Reactivar Usuario by id', function(done) {
       chai.request(server)
      .put('/users/Reactivar/10')
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
        res.body.user.UserID.should.equal('10');
        done();
      });
   });
   it('Reactivar Usuario by id Inexistente', function(done) {
       chai.request(server)
      .put('/users/Reactivar/0')
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });

});
describe('routes', function() {
  it('not found', function(done) {
       chai.request(server)
      .get('/notfound')
      .end(function(err, res){
        res.should.have.status(404);
        done();
      });
   });

  it('Index okey.', function(done) {
       chai.request(server)
      .get('/')
      .end(function(err, res){
        res.should.have.status(200);
        done();
      });
   });
});
