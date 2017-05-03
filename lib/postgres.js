var models = require('../models/index');
var logger = require('log4js').getLogger("error");
var helperPass= require('./password');



exports.getCancion = function(req, res, next) { 
	models.Cancion.find({where: {CancionID:req.params.id,Activo: true},
        attributes: ['CancionID', 'Nombre', 'Descripcion']
	  }).then(function(cancion) {
	    if (!cancion){
            res.statusCode=404;
	    	res.json('{}');
		}else{
	    	res.json(cancion);
		}
	});
    next();
}

exports.getCanciones = function(req, res, next) { 
	models.Cancion.belongsToMany(models.Genero,{through: 'GeneroCancion', foreignKey: 'CancionID'});
	models.Genero.belongsToMany(models.Cancion,{through: 'GeneroCancion', foreignKey: 'GeneroID'});	

	models.Cancion.belongsToMany(models.Artista,{through: 'ArtistaCancion', foreignKey: 'CancionID'});
	models.Artista.belongsToMany(models.Cancion,{through: 'ArtistaCancion', foreignKey: 'ArtistaID'});	


	models.Cancion.findAll({where: {Activo: true},	    
        attributes: ['CancionID', 'Nombre', 'Descripcion','Duracion'],
	include: [{model: models.Genero, attributes: ['Descripcion']},{model: models.Artista, attributes: ['Nombre','Apellido'] }]
	  }).then(function(canciones) {
	    if (!canciones){
            	res.statusCode=404;
	    	res.json('{}');
	    }else{
	    	res.json(canciones);
	    }
	});
    next();
}

exports.getCancionesPaginadas = function(req, res, next) { 
	models.Cancion.belongsToMany(models.Genero,{through: 'GeneroCancion', foreignKey: 'CancionID'});
	models.Genero.belongsToMany(models.Cancion,{through: 'GeneroCancion', foreignKey: 'GeneroID'});	

	models.Cancion.belongsToMany(models.Artista,{through: 'ArtistaCancion', foreignKey: 'CancionID'});
	models.Artista.belongsToMany(models.Cancion,{through: 'ArtistaCancion', foreignKey: 'ArtistaID'});	


	models.Cancion.findAndCountAll({where: {Activo: true},	limit: req.query.cantidadporpagina,  offset: (req.query.cantidadporpagina * req.query.pagina),
	order: [
            ['CancionID', 'ASC'],
        ],
        attributes: ['CancionID', 'Nombre', 'Descripcion','Duracion'],
	include: [{model: models.Genero, attributes: ['Descripcion']},{model: models.Artista, attributes: ['Nombre','Apellido'] }]
	  }).then(function(canciones) {
	    if (!canciones){
            	res.statusCode=404;
	    	res.json('{}');
	    }else{
	    	res.json(canciones);
	    }
	});
    next();
}

exports.altaCancion = function(req, res, next) { 
	models.Cancion.find({where: {Nombre: req.body.Nombre,Activo: true},attributes: ['CancionID']}).then(function(cancion) {
		if (!cancion) {
			models.Cancion.build({ Nombre: req.body.Nombre, Descripcion: req.body.Descripcion, Activo: true })
			  .save()
			  .then(function(CancionCreate) {
				return res.status(200).json({user: CancionCreate});
			  });
		}else{
			return res.status(404).json({ message: 'Ya existe una canción con dicho nombre.' });
		}
	});
	next();
}

exports.reactivarCancion = function(req, res, next) { 
	models.Cancion.find({where: {CancionID: req.params.id,Activo: false},attributes: ['CancionID']}).then(function(cancion) {
		if (cancion) {
			cancion.update({ Activo: 'true'}, {fields: ['Activo']})			
			  .then(function(CancionReactivada) {
				return res.status(200).json({Cancion: CancionReactivada});
			  });
		}else{
			return res.status(404).json({ message: 'No existe una canción para reactivar con dicho id.' });
		}
	});
	next();
}


exports.actualizarCancion = function(req, res, next) { 
	models.Cancion.find({where: {CancionID: req.params.id,Activo: true},attributes: ['CancionID']}).then(function(cancion) {
		if (cancion) {
			cancion.update({Nombre:req.body.Nombre,Descripcion:req.body.Descripcion, Activo: 'true'}, {fields: ['Nombre','Descripcion','Activo']})			
			  .then(function(CancionUpdate) {
				return res.status(200).json({Cancion: CancionUpdate});
			  });
		}else{
			return res.status(404).json({ message: 'No existe una canción con dicho Id.' });
		}
	});
	next();
}

exports.puntuarCancion = function(req, res, next) { 
	models.PuntuacionCancion.find({where: {UserID: req.body.UserID,CancionID: req.body.CancionID},attributes: ['CancionID']}).then(function(Puntajecancion) {
		if (!Puntajecancion) {
			models.PuntuacionCancion.build({ UserID: req.body.UserID, CancionID: req.body.CancionID, Puntaje: req.body.Puntaje })
			  .save()
			  .then(function(PuntuacionCancion) {
				return res.status(200).json({PuntuacionCancion: PuntuacionCancion});
			  });
		}else{
			return res.status(404).json({ message: 'Ya existe una puntuación para la canción por este usuario.' });
		}
	});
	next();
}

exports.obtenerPuntuacionCancion = function(req, res, next) { 
	models.PuntuacionCancion.find({where: {CancionID: req.params.id},attributes: ['CancionID']}).then(function(Puntajecancion) {
		if (Puntajecancion) {
			models.PuntuacionCancion.findAll({ where: {CancionID: req.params.id},attributes: ['CancionID',
			[models.sequelize.fn('AVG',models.sequelize.col('Puntaje')),"AVG"]], 
			group: ["CancionID"]			
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
	models.MarcaCancion.find({where: {UserID: req.body.UserID,CancionID: req.body.CancionID},attributes: ['CancionID']}).then(function(MarcaCancion) {
		if (!MarcaCancion) {
			models.MarcaCancion.build({ UserID: req.body.UserID, CancionID: req.body.CancionID })
			  .save()
			  .then(function(MarcaCancion) {
				return res.status(200).json({MarcaCancion: MarcaCancion});
			  });
		}else{
			return res.status(404).json({ message: 'Ya existe un like para la canción por este usuario.' });
		}
	});
	next();
}

exports.desmarcarCancion = function(req, res, next) { 
	models.MarcaCancion.find({where: {UserID: req.body.UserID,CancionID: req.body.CancionID},attributes: ['CancionID','UserID']}).then(function(DesmarcaCancion) {
		if (DesmarcaCancion) {
			models.MarcaCancion.destroy({where:{UserID: req.body.UserID,CancionID: req.body.CancionID},  force: true })		
			  .then(function() {
				return res.status(200).json({DesmarcarCancion: DesmarcaCancion});
			  });
		}else{
			return res.status(404).json({ message: 'No existe un like para esa canción para ese usuario.' });
		}
	});
	next();
}


exports.bajaCancion = function(req, res, next) { 
	models.Cancion.find({where: {CancionID: req.params.id,Activo: true},attributes: ['CancionID']}).then(function(cancion) {
		if (cancion) {
			cancion.update({ Activo: 'false'}, {fields: ['Activo']})			
			  .then(function(CancionDelete) {
				return res.status(200).json({Cancion: CancionDelete});
			  });
		}else{
			return res.status(404).json({ message: 'No existe una canción con dicho id.' });
		}
	});
	next();
}



exports.altaGeneroCancion = function(req, res, next) { 
	models.GeneroCancion.find({where: {CancionID: req.body.CancionID,GeneroID:req.body.GeneroID},attributes: ['CancionID']}).then(function(generoCancion) {
		if (!generoCancion) {
			models.GeneroCancion.build({ CancionID: req.body.CancionID, GeneroID: req.body.GeneroID})
			  .save()
			  .then(function(CancionCreate) {
				return res.status(200).json({user: CancionCreate});
			  });
		}else{
			return res.status(404).json({ message: 'Ya existe el género asociado a dicha canción.' });
		}
	});
	next();
}

exports.bajaGeneroCancion = function(req, res, next) { 
	models.GeneroCancion.find({where: {CancionID: req.query.id,GeneroID:req.query.idGenero},attributes: ['CancionID','GeneroID']}).then(function(generoCancion) {
		if (generoCancion) {
			models.GeneroCancion.destroy({where:{CancionID: req.query.id,GeneroID:req.query.idGenero},  force: true })		
			  .then(function() {
				return res.status(200).json({GeneroCancion: generoCancion});
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
		console.log(req.query.ids);
		var arrayIds = req.query.ids.split(',');
		console.log(arrayIds);
		console.log(JSON.stringify(arrayIds));
		models.Users.findAll(
			{where: {UserID: arrayIds,Activo: true},attributes: ['UserID', 'Name', 'LastName','Email','FechaNacimiento','ImageName']})
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
		models.Users.find({where: {UserID: userId,Activo: true},attributes: ['UserID', 'Name', 'LastName','Email','FechaNacimiento','ImageName']}).then(function(user) {
			if (!user){
				res.statusCode=401;
				res.json('{}');
			}else{
				var fileHelper = require('./filehelper');				
				var filebase64 = fileHelper.encodeImageFromFile(user.ImageName);
				var UsertoJson = user.toJSON();	
				UsertoJson.imagenbase64 = filebase64;		    	
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
	models.Users.find({ where: {Email: req.params.mail,Activo: true},
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
exports.getUserById = function(req, res, next) { 
	models.Users.find({ where: {UserID: req.params.id,Activo: true},
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


exports.updateFotoPerfil = function(req, res, next) { 
	var middleware = require('./middleware');
	var userId =middleware.isUserAuthenticated(req.headers);
	if (userId >0){
		models.Users.find({where: {UserID: userId,Activo: true},attributes: ['UserID']}).then(function(user) {
		if (user) {
			var filehelper = require('./filehelper');
			var fileName = filehelper.generateImageFromBase64(req.body.Imagen);
			if (fileName == "")
				 return res.status(401).json({ message: 'Se produjo un error al querer guardar el archivo.' });
			
			 user.update({ImageName: fileName})			
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
	models.Users.find({where: {Email: req.params.mail,Activo: true},attributes: ['UserID']}).then(function(user) {
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
exports.listarContactosUser = function(req, res, next) { 
	var middleware = require('./middleware');
	var userId =middleware.isUserAuthenticated(req.headers);
	console.log(userId);
	if (userId >0){
		models.Users.find({where: {UserID: userId,Activo: true},attributes: ['UserID']}).then(function(user) {
		if (user) {
			models.Users.hasMany(models.Contacto,{ foreignKey: 'UserID'});	
			models.Contacto.belongsTo(models.Users,{as:'usr', foreignKey: 'UserID'});
			models.Contacto.belongsTo(models.Users,{as:'contact', foreignKey: 'ContactoID'});
	
		
			models.Contacto.findAll({ where: {UserID: userId,Activo: true},attributes: ['UserID'],  raw: true ,
				include: { model: models.Users, as: 'contact',attributes: ['UserID', 'Name', 'LastName','Email','FechaNacimiento'] } } ).then(function(users) {
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
