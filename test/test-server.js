var chai = require('chai');
var chaiHttp = require('chai-http');
var server = require('../app');
var helperToken = require('../lib/service');
var helperPass= require('../lib/password');
var should = chai.should();

chai.use(chaiHttp);

describe('Password', function() {
	it('Test hash y validate', function() {
		var passwHash= helperPass.hash("test1");	       
		var assert = chai.assert;		
		 assert.equal(helperPass.validate('eMtJupw9v0dde3743f0569de80abeaca10eca65db','test1'),true);
	   });

});

describe('Tokens', function() {
	('Test Token NO OK', function(done) {
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

describe('tracks', function() {
	it('Obtener tracks', function(done) {
		       chai.request(server)
		      .get('/tracks/')
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Re Activar Cancion ', function(done) {
		       chai.request(server)
		      .put('/tracks/ReactivarCancion/1')
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Re Activar Cancion Inexistente', function(done) {
		       chai.request(server)
		      .put('/tracks/ReactivarCancion/0')
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('Obtener Cancion', function(done) {
		       chai.request(server)
		      .get('/tracks/ObtenerCancion/1')
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Obtener Cancion Inexistente', function(done) {
		       chai.request(server)
		      .get('/tracks/ObtenerCancion/0')
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('Obtener Puntuacion Cancion', function(done) {
		       chai.request(server)
		      .get('/tracks/ObtenerPuntuacionCancion/1')
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Obtener Puntuacion Cancion Inexistente', function(done) {
		       chai.request(server)
		      .get('/tracks/ObtenerPuntuacionCancion/0')
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('Marcar Cancion', function(done) {
		       chai.request(server)
		      .post('/tracks/MarcarCancion/')
		      .send({"UserID":"8","CancionID":"1"})
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Marcar Cancion ya marcada', function(done) {
		       chai.request(server)
		      .post('/tracks/MarcarCancion/')
		      .send({"UserID":"8","CancionID":"1"})
		      .end(function(err, res){
				res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('DesMarcar Cancion', function(done) {
		       chai.request(server)
		      .post('/tracks/DesmarcarCancion/')
		      .send({"UserID":"8","CancionID":"1"})
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('DesMarcar Cancion Inexistente', function(done) {
		       chai.request(server)
		      .post('/tracks/DesmarcarCancion/')
		      .send({"UserID":"8","CancionID":"0"})
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	
	it('Alta Cancion', function(done) {
		       chai.request(server)
		      .post('/tracks/AltaCancion/')
		      .send({"Nombre":helperPass.hash("testeame"),"Descripcion":helperPass.hash("testeame")})
		      .end(function(err, res){
			if (res.status==404){
				res.should.have.status(404);
			}else{
				res.should.have.status(200);
			}
			res.should.be.json;
			done();
	      	});
   	});
	it('Alta Cancion existente', function(done) {
		       chai.request(server)
		      .post('/tracks/AltaCancion/')
		      .send({"Nombre":"Testeame","Descripcion":"Testeame"})
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('Puntuar Cancion', function(done) {
		       chai.request(server)
		      .post('/tracks/PuntuarCancion/')
		      .send({"UserID":"8","CancionID":"1","Puntaje":"5"})
		      .end(function(err, res){
			if (res.status==404){
				res.should.have.status(404);
			}else{
				res.should.have.status(200);
			}
			res.should.be.json;
			done();
	      	});
   	});
	it('Alta Genero Cancion', function(done) {
		       chai.request(server)
		      .post('/tracks/AltaGeneroCancion/')
		      .send({"CancionID":"1","GeneroID":"2"})
		      .end(function(err, res){
			if (res.status==404){
				res.should.have.status(404);
			}else{
				res.should.have.status(200);
			}
			res.should.be.json;
			done();
	      	});
   	});
	it('Alta Genero Cancion Existente', function(done) {
		       chai.request(server)
		      .post('/tracks/AltaGeneroCancion/')
		      .send({"CancionID":"1","GeneroID":"2"})
		      .end(function(err, res){
			if (res.status==404){
				res.should.have.status(404);
			}else{
				res.should.have.status(200);
			}
			res.should.be.json;
			done();
	      	});
   	});
	it('Baja Genero Cancion', function(done) {
		       chai.request(server)
		      .delete('/tracks/BajaGeneroCancion?id=1&idGenero=2')
		      .end(function(err, res){
			if (res.status==404){
				res.should.have.status(404);
			}else{
				res.should.have.status(200);
			}
			res.should.be.json;
			done();
	      	});
   	});
	it('Baja Genero Cancion Inexistente', function(done) {
		       chai.request(server)
		      .delete('/tracks/BajaGeneroCancion?id=1&idGenero=2')
		      .end(function(err, res){
			if (res.status==404){
				res.should.have.status(404);
			}else{
				res.should.have.status(200);
			}
			res.should.be.json;
			done();
	      	});
   	});
	it('Actualizar Cancion', function(done) {
		       chai.request(server)
		      .put('/tracks/ActualizarCancion/1')
		      .send({"Nombre":"testeame","Descripcion":"testeame"})
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Actualizar Cancion Inexistente', function(done) {
		       chai.request(server)
		      .put('/tracks/ActualizarCancion/0')
		      .send({"Nombre":"testeame","Descripcion":"testeame"})
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('Baja Cancion', function(done) {
		       chai.request(server)
		      .delete('/tracks/BajaCancion/1')
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Baja Cancion Inexistente', function(done) {
		       chai.request(server)
		      .delete('/tracks/BajaCancion/0')
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
});


describe('Users', function() {
  
  it('Obtener Usuario Registrado by email', function(done) {
       chai.request(server)
      .post('/token/')
      .send({"Email":"nflabo@gmail.com","Password":"test"})
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
        done();
      });
   });
  it('Error al autenticar Usuario Registrado by email', function(done) {
       chai.request(server)
      .post('/token/')
      .send({"Email":"marcospernica@yahoo.com","Password":"test"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
  it('Error al autenticar Usuario password Registrado by email', function(done) {
       chai.request(server)
      .post('/token/')
      .send({"Email":"marcospernica@yahoo.com.ar","Password":"testmal"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
  it('Obtener Usuario Registrado by Mail', function(done) {
       chai.request(server)
      .get('/users/mail/marcospernica@yahoo.com.ar')
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('Name');
            res.body.Name.should.equal('Marcos');
            res.body.LastName.should.equal('Pernica');

        done();
      });
   });
   it('Obtener Usuario Registrado by id no encontrado', function(done) {
       chai.request(server)
      .get('/users/mail/nflabo@yahoo.com.ar')
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
   it('Eliminar Usuario by Mail', function(done) {
       chai.request(server)
      .delete('/users/mail/testtaller2@taller2.com')
      .end(function(err, res){
        res.should.be.json;
        done();
      });
   });
   it('Eliminar Usuario by Mail', function(done) {
       chai.request(server)
      .delete('/users/mail/mail=inexistente')
      .end(function(err, res){
        res.should.be.json;
        done();
      });
   });
   it('Registrar Usuario', function(done) {
       chai.request(server)
      .post('/users/')
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
      .post('/users/')
      .send({"Email":"testtaller2@taller2.com","Password":"test","Nombre":"taller","Apellido":"taller","FechaNacimiento":"1991-01-01"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
   it('Actualizar Usuario by id', function(done) {
       chai.request(server)
      .put('/users/11')
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
      .put('/users/0')
      .send({"Email":"nflabo@gmail.com","Password":"test","Nombre":"Nicolas","Apellido":"Fernandez","FechaNacimiento":"1991-01-01"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
   it('Eliminar Usuario by id', function(done) {
       chai.request(server)
      .delete('/users/10')
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
      .delete('/users/0')
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
   it('Listado de Contactos', function(done) {
	var tokenGenerado= helperToken.createToken(11);
       chai.request(server)
      .get('/users/me/contacts/')
	.set('authorization', 'test ' + tokenGenerado)
      .end(function(err, res){
	
        res.should.have.status(200);
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
