var jwt = require('jwt-simple');  
var moment = require('moment'); 

exports.ensureAuthenticated = function(req, res, next) {  
var env = require('node-env-file');
var process = env('./process.env');

  if(!req.headers.authorization) {
    return res
      .status(401)
      .send({message: "No se encuentra autorizado"});
  }
  var token = req.headers.authorization.split(" ")[1];
  var payload = jwt.decode(token, process.TOKEN_SECRET, function() {});

  if(payload.exp <= moment().unix()) {
     return res
         .status(401)
        .send({message: "Token expirado."});
  }
  return res
         .status(200)
        .send({UserID: payload.sub});
}

exports.isUserAuthenticated = function(headers) {  
var env = require('node-env-file');
var process = env('./process.env');

  if(!headers.authorization) {
    return -1;
  }
  var token = headers.authorization.split(" ")[1];
  var payload = jwt.decode(token, process.TOKEN_SECRET, function() {});

  if(payload.exp <= moment().unix()) {
     return 0;
  }
  return payload.sub;
}
