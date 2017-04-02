var jwt = require('jwt-simple');  
var moment = require('moment');  

exports.ensureAuthenticated = function(req, res, next) {  
  if(!req.headers.authorization) {
    return res
      .status(403)
      .send({message: "No se encuentra autorizado"});
  }

  var token = req.headers.authorization.split(" ")[1];
  var payload = jwt.decode(token, procees.env.TOKEN_SECRET);

  if(payload.exp <= moment().unix()) {
     return res
         .status(401)
        .send({message: "Token expirado."});
  }

  req.user = payload.sub;
  next();
}
