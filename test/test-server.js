var chai = require('chai');
var chaiHttp = require('chai-http');
var server = require('../app');
var should = chai.should();

chai.use(chaiHttp);


describe('Users', function() {
  it('Obtener Usuario Registrado', function(done) {
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
});
