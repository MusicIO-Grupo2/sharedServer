var models = require('../models/index');

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
	      
	    }
	  }).then(function(user) {
	    res.json(user);
	}).catch ( function (err) {
	    console.error(err); 
	     res.statusCode = 500;
	     res.json({ errors: ['No se puede obtener el usuario'] });
	});
    next();
}

