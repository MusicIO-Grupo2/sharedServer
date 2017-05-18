var models = require('../models/index');
var logger = require('log4js').getLogger("error");
var helperPass= require('./password');



exports.getCancion = function(req, res, next) { 
	models.Track.find({where: {trackId:req.params.id,active: true},
        attributes: ['trackId', 'name', 'description']
	  }).then(function(track) {
	    if (!track){
		    res.statusCode=404;
		    	res.json('{}');
		}else{
		    	res.json(track);
		}
	});
    next();
}

exports.getCanciones = function(req, res, next) { 
	models.Track.belongsToMany(models.Gender,{through: 'GenderTrack', foreignKey: 'trackId'});
	models.Gender.belongsToMany(models.Track,{through: 'GenderTrack', foreignKey: 'genderId'});	

	models.Track.belongsToMany(models.Artist,{through: 'ArtistTrack', foreignKey: 'trackId'});
	models.Artist.belongsToMany(models.Track,{through: 'ArtistTrack', foreignKey: 'artistId'});	


	models.Track.findAll({where: {active: true},	    
        attributes: ['trackId', 'name', 'description','duration'],
	include: [{model: models.Gender, attributes: ['description']},{model: models.Artist, attributes: ['firstName','lastName'] }]
	  }).then(function(canciones) {
	    if (!canciones){
            	res.statusCode=404;
	    	res.json('{}');
	    }else{
	    	res.json({canciones});
	    }
	});
    next();
}

exports.getCancionesPaginadas = function(req, res, next) { 
	models.Track.belongsToMany(models.Gender,{through: 'GenderTrack', foreignKey: 'trackId'});
	models.Gender.belongsToMany(models.Track,{through: 'GenderTrack', foreignKey: 'genderId'});	

	models.Track.belongsToMany(models.Artist,{through: 'ArtistTrack', foreignKey: 'trackId'});
	models.Artist.belongsToMany(models.Track,{through: 'ArtistTrack', foreignKey: 'artistId'});	


	models.Track.findAndCountAll({where: {active: true},	limit: req.query.cantidadporpagina,  offset: (req.query.cantidadporpagina * req.query.pagina),
	order: [
            ['trackId', 'ASC'],
        ],
        attributes: ['trackId', 'name', 'description','duration'],
	include: [{model: models.Gender, attributes: ['description']},{model: models.Artist, attributes: ['firstName','lastName'] }]
	  }).then(function(tracks) {
	    if (!tracks){
            	res.statusCode=404;
	    	res.json('{}');
	    }else{
	    	res.json(tracks);
	    }
	});
    next();
}

exports.altaCancion = function(req, res, next) { 
	models.Track.find({where: {name: req.body.name,active: true},attributes: ['trackId']}).then(function(track) {
		if (!track) {
			models.Track.build({ name: req.body.name, description: req.body.description, active: true })
			  .save()
			  .then(function(trackCreate) {
				return res.status(200).json({track: trackCreate});
			  });
		}else{
			return res.status(404).json({ message: 'Ya existe una canción con dicho nombre.' });
		}
	});
	next();
}

exports.reactivarCancion = function(req, res, next) { 
	models.Track.find({where: {trackId: req.params.id,active: false},attributes: ['trackId']}).then(function(track) {
		if (track) {
			track.update({ active: 'true'}, {fields: ['active']})			
			  .then(function(reactivatetrack) {
				return res.status(200).json({track: reactivatetrack});
			  });
		}else{
			return res.status(404).json({ message: 'No existe una canción para reactivar con dicho id.' });
		}
	});
	next();
}


exports.actualizarCancion = function(req, res, next) { 
	models.Track.find({where: {trackId: req.params.id,active: true},attributes: ['trackId']}).then(function(track) {
		if (track) {
			track.update({name:req.body.name,description:req.body.description, active: 'true'}, {fields: ['name','description','active']})			
			  .then(function(trackUpdate) {
				return res.status(200).json({track: trackUpdate});
			  });
		}else{
			return res.status(404).json({ message: 'No existe una canción con dicho Id.' });
		}
	});
	next();
}

exports.puntuarCancion = function(req, res, next) { 
	var middleware = require('./middleware');
	var userId =middleware.isUserAuthenticated(req.headers);
	if (userId >0){

		models.RateTrack.find({where: {userId: userId,trackId: req.params.id},attributes: ['trackId']}).then(function(rateTrack) {
			if (!rateTrack) {
				models.RateTrack.build({ userId: userId, trackId: req.params.id, rate: req.body.rate })
				  .save()
				  .then(function(RateTrack) {
					return res.status(200).json({track: RateTrack});
				  });
			}else{
				return res.status(404).json({ message: 'Ya existe una puntuación para la canción por este usuario.' });
			}
		});
		next();
	}else if (userId == -1){
		return res.status(401).json({ message: 'No existe token.' });
	}else if (userId == 0){
		return res.status(401).json({ message: 'Token Expirado.' });
	}
}

exports.obtenerPuntuacionCancion = function(req, res, next) { 
	models.RateTrack.find({where: {trackId: req.params.id},attributes: ['trackId']}).then(function(Puntajecancion) {
		if (Puntajecancion) {
			models.RateTrack.findAll({ where: {trackId: req.params.id},attributes: ['trackId',
			[models.sequelize.fn('AVG',models.sequelize.col('rate')),"AVG"]], 
			group: ["trackId"]			
			} ).then(function(Popularidad) {
				return res.status(200).json(Popularidad);

			});
		}else{
			return res.status(404).json({ message: 'No existe una canción con ese id.' });
		}
	});
	next();
}

exports.marcarCancion = function(req, res, next) { 
	var middleware = require('./middleware');
	var userId =middleware.isUserAuthenticated(req.headers);
	if (userId >0){
		models.FavoriteTrack.find({where: {userId: userId,trackId: req.params.id},attributes: ['trackId']}).then(function(FavoriteTrack) {
			if (!FavoriteTrack) {
				models.FavoriteTrack.build({ userId: userId, trackId: req.params.id })
				  .save()
				  .then(function(FavoriteTrack) {
					return res.status(200).json({track: FavoriteTrack});
				  });
			}else{
				return res.status(404).json({ message: 'Ya existe un like para la canción por este usuario.' });
			}
		});
		next();
	}else if (userId == -1){
		return res.status(401).json({ message: 'No existe token.' });
	}else if (userId == 0){
		return res.status(401).json({ message: 'Token Expirado.' });
	}
}

exports.desmarcarCancion = function(req, res, next) { 
	var middleware = require('./middleware');
	var userId =middleware.isUserAuthenticated(req.headers);
	if (userId >0){

		models.FavoriteTrack.find({where: {userId: userId,trackId: req.params.id},attributes: ['trackId','userId']}).then(function(DesmarcaCancion) {
			if (DesmarcaCancion) {
				models.FavoriteTrack.destroy({where:{userId: userId,trackId: req.params.id},  force: true })		
				  .then(function() {
					return res.status(200).json({track: DesmarcaCancion});
				  });
			}else{
				return res.status(404).json({ message: 'No existe un like para esa canción para ese usuario.' });
			}
		});
		next();
	}else if (userId == -1){
		return res.status(401).json({ message: 'No existe token.' });
	}else if (userId == 0){
		return res.status(401).json({ message: 'Token Expirado.' });
	}
}


exports.bajaCancion = function(req, res, next) { 
	models.Track.find({where: {trackId: req.params.id,active: true},attributes: ['trackId']}).then(function(track) {
		if (track) {
			track.update({ active: 'false'}, {fields: ['active']})			
			  .then(function(trackDelete) {
				return res.status(200).json({track: trackDelete});
			  });
		}else{
			return res.status(404).json({ message: 'No existe una canción con dicho id.' });
		}
	});
	next();
}



exports.altaGeneroCancion = function(req, res, next) { 
	models.GenderTrack.find({where: {trackId: req.params.id,genderId:req.params.genderId},attributes: ['trackId']}).then(function(genderTrack) {
		if (!genderTrack) {
			models.GenderTrack.build({ trackId: req.params.id, genderId: req.params.genderId})
			  .save()
			  .then(function(trackCreacte) {
				return res.status(200).json({user: trackCreacte});
			  });
		}else{
			return res.status(404).json({ message: 'Ya existe el género asociado a dicha canción.' });
		}
	});
	next();
}

exports.bajaGeneroCancion = function(req, res, next) { 
	models.GenderTrack.find({where: {trackId: req.params.id,genderId:req.params.generoid},attributes: ['trackId','genderId']}).then(function(genderTrack) {
		if (genderTrack) {
			models.GenderTrack.destroy({where:{trackId: req.query.id,genderId:req.query.idGenero},  force: true })		
			  .then(function() {
				return res.status(200).json({GenderTrack: genderTrack});
			  });
		}else{
			return res.status(404).json({ message: 'No existe un genero asociado a la canción.' });
		}
	});
	next();
}

exports.getUsers = function(req, res, next) { 
	var middleware = require('./middleware');
	var userId =middleware.isUserAuthenticated(req.headers);
	if (userId >0){
		var arrayIds = req.query.ids.split(',');
		models.Users.findAll(
			{where: {userId: arrayIds,active: true},attributes: ['userId','userName', 'firstName', 'lastName','country','email','birthdate','image']})
		.then(function(user) {
		    if (!user){
		    res.statusCode=401;
		    	res.json('{}');
			}else{
		    	res.json(user);
			}
		});
		next();
	}else if (userId == -1){
		return res.status(401).json({ message: 'No existe token.' });
	}else if (userId == 0){
		return res.status(401).json({ message: 'Token Expirado.' });
	}
}


exports.getUserMe = function(req, res, next) { 
	var middleware = require('./middleware');
	var userId =middleware.isUserAuthenticated(req.headers);
	if (userId >0){
		models.Users.find({where: {userId: userId,active: true},
		attributes: ['userId','userName', 'firstName', 'lastName','country','email','birthdate','image']})
		.then(function(user) {
			if (!user){
				res.statusCode=401;
				res.json('{}');
			}else{
				if (user.image){				
					var fileHelper = require('./filehelper');				
					var filebase64 = fileHelper.encodeImageFromFile(user.image);
					var UsertoJson = user.toJSON();	
					UsertoJson.image = filebase64;		    	
				}else{
					var UsertoJson = user.toJSON();	
					UsertoJson.image ="";
				}
				res.json(UsertoJson);
			}
		});
		next();
	}else if (userId == -1){
		return res.status(401).json({ message: 'No existe token.' });
	}else if (userId == 0){
		return res.status(401).json({ message: 'Token Expirado.' });
	}
}



exports.getUserByMail = function(req, res, next) { 
	models.Users.find({ where: {email: req.params.email,active: true},
        		attributes: ['userId','userName', 'firstName', 'lastName','country','email','birthdate','image']})
	  .then(function(user) {
			if (!user){
				res.statusCode=401;
				res.json('{}');
			}else{
				if (user.image){				
					var fileHelper = require('./filehelper');				
					var filebase64 = fileHelper.encodeImageFromFile(user.image);
					var UsertoJson = user.toJSON();	
					UsertoJson.image = filebase64;		    	
				}else{
					var UsertoJson = user.toJSON();	
					UsertoJson.image ="";
				}
				res.json(UsertoJson);
			}
		});
	    next();
}

exports.registerUser = function(req, res, next) { 
	models.Users.find({where: {email: req.body.email,active: true},attributes: ['userId']}).then(function(user) {
		if (!user) {
			console.log(req.body.country);
			var passwHash= helperPass.hash(req.body.password);
			models.Users.build(
			  {userName:req.body.userName, firstName: req.body.firstName,  lastName: req.body.lastName, 
				password: passwHash, email: req.body.email,country: req.body.country,birthdate: req.body.birthdate, active: true })
			  .save()
			  .then(function(UserCreate) {
				if(req.body.image){
					var filehelper = require('./filehelper');
					var fileName = filehelper.generateImageFromBase64(req.body.image);
					if (fileName == "")
						return res.status(401).json({ message: 'Se produjo un error al querer guardar el archivo.' });
				
					UserCreate.update({image: fileName}).then(function(UserUpdate) {
						return res.status(200).json({user: UserUpdate});
				  	});
				}else{
					return res.status(200).json({user: UserCreate});
				}
			  });
		}else{
			return res.status(401).json({ message: 'Ya existe un usuario registrado con dicho email.' });
		}
	});
	next();
}


exports.updateFotoPerfil = function(req, res, next) { 
	var middleware = require('./middleware');
	var userId =middleware.isUserAuthenticated(req.headers);
	if (userId >0){
		models.Users.find({where: {userId: userId,active: true},attributes: ['userId']}).then(function(user) {
		if (user) {
			if(req.body.image){
				var filehelper = require('./filehelper');
				var fileName = filehelper.generateImageFromBase64(req.body.image);
				if (fileName == "")
					return res.status(401).json({ message: 'Se produjo un error al querer guardar el archivo.' });
			}
			
			 user.update({image: fileName})			
			  .then(function(UserUpdate) {
				return res.status(200).json({user: UserUpdate});
			  });
		}else{
			return res.status(401).json({ message: 'No existe un usuario activo / registrado con dicho id.' });
		}
		});
		next();
	}else if (userId == -1){
		return res.status(401).json({ message: 'No existe token.' });
	}else if (userId == 0){
		return res.status(401).json({ message: 'Token Expirado.' });
	}
}

exports.updateUser = function(req, res, next) { 
	var middleware = require('./middleware');
	var userId =middleware.isUserAuthenticated(req.headers);
	if (userId >0){
		models.Users.find({where: {userId: userId,active: true},attributes: ['userId']}).then(function(user) {
			if (user) {
				var passwHash= helperPass.hash(req.body.password);
				if(req.body.image){
					var filehelper = require('./filehelper');
					var fileName = filehelper.generateImageFromBase64(req.body.image);
					if (fileName == "")
						return res.status(401).json({ message: 'Se produjo un error al querer guardar el archivo.' });
				}
				user.update({userName:req.body.userName, firstName: req.body.firstName,  lastName: req.body.lastName, 
					password: passwHash, email: req.body.email,country: req.body.country,birthdate: req.body.birthdate,image: fileName, active: true })			
				  .then(function(UserUpdate) {
					return res.status(200).json({user: UserUpdate});
				  });
			}else{
				return res.status(401).json({ message: 'No existe un usuario activo / registrado con dicho id.' });
			}
		});
		next();
	}else if (userId == -1){
		return res.status(401).json({ message: 'No existe token.' });
	}else if (userId == 0){
		return res.status(401).json({ message: 'Token Expirado.' });
	}
}

exports.deleteUserByMail = function(req, res, next) { 
	models.Users.find({where: {email: req.params.email,active: true},attributes: ['userId']}).then(function(user) {
		if (user) {
			user.update({ active: 'false'}, {fields: ['active']})			
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
	models.Users.find({where: {userId: req.params.id,active: true},attributes: ['userId']}).then(function(user) {
		if (user) {
			user.update({ active: 'false'}, {fields: ['active']})			
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
	models.Users.find({where: {userId: req.params.id,active: false},attributes: ['userId']}).then(function(user) {
		if (user) {
			user.update({ active: 'true'}, {fields: ['active']})			
			  .then(function(UserActivado) {
				return res.status(200).json({user: UserActivado});
			  });
		}else{
			return res.status(401).json({ message: 'No existe un usuario inactivo / registrado con dicho id.' });
		}
	});
	next();
}
exports.listarContactosUser = function(req, res, next) { 
	var middleware = require('./middleware');
	var userId =middleware.isUserAuthenticated(req.headers);
	if (userId >0){
		models.Users.find({where: {userId: userId,active: true},attributes: ['userId']}).then(function(user) {
		if (user) {
			models.Users.hasMany(models.Contact,{ foreignKey: 'userId'});	
			models.Contact.belongsTo(models.Users,{as:'usr', foreignKey: 'userId'});
			models.Contact.belongsTo(models.Users,{as:'contact', foreignKey: 'contactId'});
	

			models.Contact.findAll({ where: {userId: userId,active: true},attributes: ['userId'],  raw: true ,
				include: { model: models.Users, as: 'contact',attributes: ['userId','userName', 'firstName', 'lastName','country','email','birthdate','image']} } ).then(function(users) {
				return res.status(200).json(users);

			});
		}else{
			return res.status(401).json({ message: 'No existe un usuario inactivo / registrado con dicho id para obtener los contactos.' });
		}
		});
		next();
	}else if (userId == -1){
		return res.status(401).json({ message: 'No existe token.' });
	}else if (userId == 0){
		return res.status(401).json({ message: 'Token Expirado.' });
	}	
	
}
