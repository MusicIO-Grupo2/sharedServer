var service = require('./service');
var models = require('../models/index');
var validatePass= require('./password');

exports.emailLogin = function(req, res) {
	models.Users.find({where: {Email: req.body.Email},attributes: ['UserID', 'Name', 'LastName','Passwd','Email','FechaNacimiento']}).then(function(user) {
		if (!user) {
			return res.status(401).json({ message: 'Email Invalido' });
		}else{
			if(!validatePass.validate(user.Passwd,req.body.Password))
				return res.status(401).json({ message: 'Invalid Password' });
			
		}
		
		return res.status(200).json({token: service.createToken(user.UserID),user: user});
	});
}



