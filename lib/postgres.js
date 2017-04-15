var models = require('../models/index');
var logger = require('log4js').getLogger("error");
var helperPass= require('./password');

exports.getUser = function(req, res, next) { 
	models.Users.find({
	    where: {
		 $or: [
			     {
			      UserID: req.query.id
			    },
			    {
			      Email: req.query.email
			    }
		]
	      
	    },
        attributes: ['UserID', 'Name', 'LastName','Email','FechaNacimiento']
	  }).then(function(user) {
	    if (!user){
            res.statusCode=401;
	    	res.json('{}');
		}else{
	    	res.json(user);
		}
	});
    next();
}

exports.registerUser = function(req, res, next) { 
	models.Users.find({where: {Email: req.body.Email,Activo: true},attributes: ['UserID']}).then(function(user) {
		if (!user) {
			var passwHash= helperPass.hash(req.body.Password);
			models.Users.build({ Name: req.body.Nombre,  LastName: req.body.Apellido, Passwd: passwHash, Email: req.body.Email,FechaNacimiento: req.body.FechaNacimiento, Activo: true })
			  .save()
			  .then(function(UserCreate) {
				return res.status(200).json({user: UserCreate});
			  });
		}else{
			return res.status(401).json({ message: 'Ya existe un usuario registrado con dicho email.' });
		}
	});
	next();
}
exports.updateUser = function(req, res, next) { 
	models.Users.find({where: {UserID: req.params.id,Activo: true},attributes: ['UserID']}).then(function(user) {
		if (user) {
			var passwHash= helperPass.hash(req.body.Password);
			user.update({Name: req.body.Nombre,  LastName: req.body.Apellido, Passwd: passwHash, Email: req.body.Email,FechaNacimiento: req.body.FechaNacimiento})			
			  .then(function(UserUpdate) {
				return res.status(200).json({user: UserUpdate});
			  });
		}else{
			return res.status(401).json({ message: 'No existe un usuario activo / registrado con dicho id.' });
		}
	});
	next();
}
exports.deleteUserByMail = function(req, res, next) { 
	models.Users.find({where: {Email: req.query.Email,Activo: true},attributes: ['UserID']}).then(function(user) {
		if (user) {
			user.update({ Activo: 'false'}, {fields: ['Activo']})			
			  .then(function(UserDelete) {
				return res.status(200).json({user: UserDelete});
			  });
		}else{
			return res.status(401).json({ message: 'No existe un usuario activo / registrado con dicho id.' });
		}
	});
	next();
}
exports.deleteUser = function(req, res, next) { 
	models.Users.find({where: {UserID: req.params.id,Activo: true},attributes: ['UserID']}).then(function(user) {
		if (user) {
			user.update({ Activo: 'false'}, {fields: ['Activo']})			
			  .then(function(UserDelete) {
				return res.status(200).json({user: UserDelete});
			  });
		}else{
			return res.status(401).json({ message: 'No existe un usuario activo / registrado con dicho id.' });
		}
	});
	next();
}
exports.reactivarUser = function(req, res, next) { 
	models.Users.find({where: {UserID: req.params.id,Activo: false},attributes: ['UserID']}).then(function(user) {
		if (user) {
			user.update({ Activo: 'true'}, {fields: ['Activo']})			
			  .then(function(UserActivado) {
				return res.status(200).json({user: UserActivado});
			  });
		}else{
			return res.status(401).json({ message: 'No existe un usuario inactivo / registrado con dicho id.' });
		}
	});
	next();
}
