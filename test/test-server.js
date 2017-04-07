var chai = require('chai');
var chaiHttp = require('chai-http');
var server = require('../app');
var should = chai.should();

chai.use(chaiHttp);



describe('Users', function() {
  it('Obtener Token by mail y password', function(done) {
       chai.request(server)
      .get('/Registrado?email=nflabo')
      .end(function(err, res){
        res.should.have.status(200);
        res.should.be.json;
        res.body.should.have.property('Name');
            res.body.Name.should.equal('Nicolas');
            res.body.LastName.should.equal('Fernandez');

        done();
      });
   });
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
  it('Obtener Usuario Registrado by id', function(done) {
       chai.request(server)
      .get('/Registrado?id=1')
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
      .get('/Registrado?id=0')
      .end(function(err, res){
        res.should.have.status(401);
        res.should.be.json;
        done();
      });
   });
});
describe('routes', function() {
  it('Index okey.', function(done) {
       chai.request(server)
      .get('/')
      .end(function(err, res){
        res.should.have.status(200);
        done();
      });
   });
});
