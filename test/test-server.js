var chai = require('chai');
var chaiHttp = require('chai-http');
var server = require('../app');
var helperToken = require('../lib/service');
var fileHelper = require('../lib/filehelper');
var helperAuth = require('../lib/middleware');
var helperPass= require('../lib/password');
var should = chai.should();

chai.use(chaiHttp);

describe('Password', function() {
	it('Test hash y validate', function() {
		;		
		var passwHash= helperPass.hash("test1");	       
		var assert = chai.assert;
		assert.equal(helperPass.validate('eMtJupw9v0dde3743f0569de80abeaca10eca65db','test1'),true);
		 
	   });

});

describe('Tokens', function() {
	it('Test Token NO OK', function(done) {
	       chai.request(server)
	      .get('/private/')
	      .end(function(err, res){
		res.should.have.status(401);
		res.should.be.json;
		done();
	      });
	   });
	('Test Token Sin Header', function(done) {
		chai.request(server)
		.post('/tracks/1/like')
		.set('authorization', 'test ' + 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEwLCJpYXQiOjE0OTIyODc5NTAsImV4cCI6MTQ5MjI4Nzk1MH0.kNRiDUt-LJ6bVc81sSgCVdPxeIwiZceJRswlAjstSbo')
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
	it('Obtener tracks Paginados', function(done) {
		       chai.request(server)
		      .get('/tracks/paginate?cantidadporpagina=10&pagina=0')
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
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
		      .get('/tracks/1')
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Obtener Cancion Inexistente', function(done) {
		       chai.request(server)
		      .get('/tracks/0')
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('Obtener Puntuacion Cancion', function(done) {
		       chai.request(server)
		      .get('/tracks/1/popularity/')
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Obtener Puntuacion Cancion Inexistente', function(done) {
		       chai.request(server)
		      .get('/tracks/0/popularity/')
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('Marcar Cancion', function(done) {
		   var tokenGenerado= helperToken.createToken(7);
		       chai.request(server)
		      .post('/tracks/1/like')
		      .set('authorization', 'test ' + tokenGenerado)
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Marcar Cancion ya marcada', function(done) {
		   var tokenGenerado= helperToken.createToken(7);
		       chai.request(server)
		      .post('/tracks/1/like')
		      .set('authorization', 'test ' + tokenGenerado)
		      .end(function(err, res){
				res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('DesMarcar Cancion', function(done) {
			var tokenGenerado= helperToken.createToken(7);
		       chai.request(server)
		      .post('/tracks/1/unlike')
		      .set('authorization', 'test ' + tokenGenerado)
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('DesMarcar Cancion Inexistente', function(done) {
			var tokenGenerado= helperToken.createToken(7);
		       chai.request(server)
		      .post('/tracks/1/unlike')
			.set('authorization', 'test ' + tokenGenerado)
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	
	it('Alta Cancion', function(done) {
		       chai.request(server)
		      .post('/tracks/')
		      .send({"name":helperPass.hash("testeame"),"description":helperPass.hash("testeame")})
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
		      .post('/tracks/')
		      .send({"name":"Testeame","description":"Testeame"})
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('Puntuar Cancion', function(done) {
			var tokenGenerado= helperToken.createToken(7);
		       chai.request(server)
		      .post('/tracks/1/popularity')
			.set('authorization', 'test ' + tokenGenerado)
		      .send({"rate":"5"})
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
		      .post('/tracks/1/gender/2/')
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
		      .post('/tracks/1/gender/2/')
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
		      .delete('/tracks/1/gender/2')
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
		      .delete('/tracks/1/gender/2')
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
		      .put('/tracks/1')
		      .send({"name":"testeame","description":"testeame"})
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Actualizar Cancion Inexistente', function(done) {
		       chai.request(server)
		      .put('/tracks/0')
		      .send({"name":"testeame","description":"testeame"})
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
	it('Baja Cancion', function(done) {
		       chai.request(server)
		      .delete('/tracks/1')
		      .end(function(err, res){
			res.should.have.status(200);
			res.should.be.json;
			done();
	      	});
   	});
	it('Baja Cancion Inexistente', function(done) {
		       chai.request(server)
		      .delete('/tracks/0')
		      .end(function(err, res){
			res.should.have.status(404);
			res.should.be.json;
			done();
	      	});
   	});
});


describe('Users', function() {

  it('Usuario Actualizar Foto', function(done) {
	var tokenGenerado= helperToken.createToken(7);
       chai.request(server)
      .put('/users/me/photo/')
	.set('authorization', 'test ' + tokenGenerado)
      .send({"image":"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAAAAACPAi4CAAAAB3RJTUUH1QEHDxEhOnxCRgAAAAlwSFlzAAAK8AAACvABQqw0mAAAAXBJREFUeNrtV0FywzAIxJ3+K/pZyctKXqamji0htEik9qEHc3JkWC2LRPCS6Zh9HIy/AP4FwKf75iHEr6eU6Mt1WzIOFjFL7IFkYBx3zWBVkkeXAUCXwl1tvz2qdBLfJrzK7ixNUmVdTIAB8PMtxHgAsFNNkoExRKA+HocriOQAiC+1kShhACwSRGAEwPP96zYIoE8Pmph9qEWWKcCWRAfA/mkfJ0F6dSoA8KW3CRhn3ZHcW2is9VOsAgoqHblncAsyaCgcbqpUZQnWoGTcp/AnuwCoOUjhIvCvN59UBeoPZ/AYyLm3cWVAjxhpqREVaP0974iVwH51d4AVNaSC8TRNNYDQEFdlzDW9ob10YlvGQm0mQ+elSpcCCBtDgQD7cDFojdx7NIeHJkqi96cOGNkfZOroZsHtlPYoR7TOp3Vmfa5+49uoSSRyjfvc0A1kLx4KC6sNSeDieD1AWhrJLe0y+uy7b9GjP83l+m68AJ72AwSRPN5g7uwUAAAAAElFTkSuQmCC"})
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        done();
      });
   });
  
  it('Obtener Usuario Registrado by email', function(done) {
       chai.request(server)
      .post('/token/')
      .send({"email":"nflabo@gmail.com","password":"test"})
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
        done();
      });
   });
  it('Obtener Usuarios by ids', function(done) {
	var tokenGenerado= helperToken.createToken(7);
       chai.request(server)
      .get('/users?ids=7,8,9')
	.set('authorization', 'test ' + tokenGenerado)
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        done();
      });
   });
  it('Obtener Usuario me', function(done) {
	var tokenGenerado= helperToken.createToken(7);
       chai.request(server)
      .get('/users/me/')
	.set('authorization', 'test ' + tokenGenerado)
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        done();
      });
   });
  it('Error al autenticar Usuario Registrado by email', function(done) {
       chai.request(server)
      .post('/token/')
      .send({"email":"marcospernica@yahoo.com","password":"test"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
  it('Error al autenticar Usuario password Registrado by email', function(done) {
       chai.request(server)
      .post('/token/')
      .send({"email":"marcospernica@yahoo.com.ar","password":"testmal"})
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
        res.body.should.have.property('firstName');
            res.body.firstName.should.equal('Marcos');
            res.body.lastName.should.equal('Pernica');

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
      .delete('/users/email/testtaller2@taller2.com')
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
      .send({"email":helperPass.hash("talli"),"password":"test","firstName":"taller","lastName":"taller","birthdate":"1991-01-01","country":"Argentina","image":"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAAAAACPAi4CAAAAB3RJTUUH1QEHDxEhOnxCRgAAAAlwSFlzAAAK8AAACvABQqw0mAAAAXBJREFUeNrtV0FywzAIxJ3+K/pZyctKXqamji0htEik9qEHc3JkWC2LRPCS6Zh9HIy/AP4FwKf75iHEr6eU6Mt1WzIOFjFL7IFkYBx3zWBVkkeXAUCXwl1tvz2qdBLfJrzK7ixNUmVdTIAB8PMtxHgAsFNNkoExRKA+HocriOQAiC+1kShhACwSRGAEwPP96zYIoE8Pmph9qEWWKcCWRAfA/mkfJ0F6dSoA8KW3CRhn3ZHcW2is9VOsAgoqHblncAsyaCgcbqpUZQnWoGTcp/AnuwCoOUjhIvCvN59UBeoPZ/AYyLm3cWVAjxhpqREVaP0974iVwH51d4AVNaSC8TRNNYDQEFdlzDW9ob10YlvGQm0mQ+elSpcCCBtDgQD7cDFojdx7NIeHJkqi96cOGNkfZOroZsHtlPYoR7TOp3Vmfa5+49uoSSRyjfvc0A1kLx4KC6sNSeDieD1AWhrJLe0y+uy7b9GjP83l+m68AJ72AwSRPN5g7uwUAAAAAElFTkSuQmCC"})
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
        res.body.user.firstName.should.equal('taller');
       done();
      });
   });
   it('Registrar Usuario Registrado', function(done) {
       chai.request(server)
      .post('/users/')
            .send({"email":"nflabo@gmail.com","password":"test","firstName":"taller","lastName":"taller","birthdate":"1991-01-01","country":"Argentina","image":"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAAAAACPAi4CAAAAB3RJTUUH1QEHDxEhOnxCRgAAAAlwSFlzAAAK8AAACvABQqw0mAAAAXBJREFUeNrtV0FywzAIxJ3+K/pZyctKXqamji0htEik9qEHc3JkWC2LRPCS6Zh9HIy/AP4FwKf75iHEr6eU6Mt1WzIOFjFL7IFkYBx3zWBVkkeXAUCXwl1tvz2qdBLfJrzK7ixNUmVdTIAB8PMtxHgAsFNNkoExRKA+HocriOQAiC+1kShhACwSRGAEwPP96zYIoE8Pmph9qEWWKcCWRAfA/mkfJ0F6dSoA8KW3CRhn3ZHcW2is9VOsAgoqHblncAsyaCgcbqpUZQnWoGTcp/AnuwCoOUjhIvCvN59UBeoPZ/AYyLm3cWVAjxhpqREVaP0974iVwH51d4AVNaSC8TRNNYDQEFdlzDW9ob10YlvGQm0mQ+elSpcCCBtDgQD7cDFojdx7NIeHJkqi96cOGNkfZOroZsHtlPYoR7TOp3Vmfa5+49uoSSRyjfvc0A1kLx4KC6sNSeDieD1AWhrJLe0y+uy7b9GjP83l+m68AJ72AwSRPN5g7uwUAAAAAElFTkSuQmCC"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
it('Reactivar Usuario by id', function(done) {
       chai.request(server)
      .put('/users/Reactivar/11')
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
        res.body.user.userId.should.equal('11');
        done();
      });
   });
   it('Actualizar Usuario by id', function(done) {
	var tokenGenerado= helperToken.createToken(11);
       chai.request(server)
	.put('/users/me')
	.set('authorization', 'test ' + tokenGenerado)
	.send({"email":"testtaller2@taller2.com","password":"test","firstName":"taller","lastName":"taller","birthdate":"1991-01-01","country":"Argentina","image":"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAAAAACPAi4CAAAAB3RJTUUH1QEHDxEhOnxCRgAAAAlwSFlzAAAK8AAACvABQqw0mAAAAXBJREFUeNrtV0FywzAIxJ3+K/pZyctKXqamji0htEik9qEHc3JkWC2LRPCS6Zh9HIy/AP4FwKf75iHEr6eU6Mt1WzIOFjFL7IFkYBx3zWBVkkeXAUCXwl1tvz2qdBLfJrzK7ixNUmVdTIAB8PMtxHgAsFNNkoExRKA+HocriOQAiC+1kShhACwSRGAEwPP96zYIoE8Pmph9qEWWKcCWRAfA/mkfJ0F6dSoA8KW3CRhn3ZHcW2is9VOsAgoqHblncAsyaCgcbqpUZQnWoGTcp/AnuwCoOUjhIvCvN59UBeoPZ/AYyLm3cWVAjxhpqREVaP0974iVwH51d4AVNaSC8TRNNYDQEFdlzDW9ob10YlvGQm0mQ+elSpcCCBtDgQD7cDFojdx7NIeHJkqi96cOGNkfZOroZsHtlPYoR7TOp3Vmfa5+49uoSSRyjfvc0A1kLx4KC6sNSeDieD1AWhrJLe0y+uy7b9GjP83l+m68AJ72AwSRPN5g7uwUAAAAAElFTkSuQmCC"})      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
            res.body.user.firstName.should.equal('taller');
            res.body.user.lastName.should.equal('taller');

        done();
      });
   });
   it('Actualizar Usuario by id inexistente', function(done) {
       chai.request(server)
      .put('/users/me')
      .send({"email":"testtaller2@taller2.com","password":"test","firstName":"taller","lastName":"taller","birthdate":"1991-01-01","country":"Argentina"})
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
   it('Eliminar Usuario by id', function(done) {
       chai.request(server)
      .delete('/users/11')
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
        res.body.user.userId.should.equal('11');
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
      .put('/users/Reactivar/11')
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('user');
        res.body.user.userId.should.equal('11');
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
