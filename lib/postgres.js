var models = require('../models/index');
var logger = require('log4js').getLogger("Postgres");

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

	}).catch ( function (err) {
	    logger.error(err); 
	     res.statusCode = 500;
	     res.json({ errors: ['No se puede obtener el usuario'] });
	});
    next();
}

