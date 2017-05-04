var service = require('./service');
var models = require('../models/index');
var validatePass= require('./password');

exports.emailLogin = function(req, res) {
	models.Users.find({where: {email: req.body.email,active:true},attributes: ['UserID','userName', 'firstName', 'lastName','country','email','password','birthdate','image']}).then(function(user) {
		if (!user) {
			return res.status(401).json({ message: 'Email Invalido' });
		}else{
			if(!validatePass.validate(user.password,req.body.password))
				return res.status(401).json({ message: 'Invalid Password' });
			
		}
		
		return res.status(200).json({token: service.createToken(user.UserID),user: user});
	});
}



