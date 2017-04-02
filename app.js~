var express = require('express');
var bodyParser = require('body-parser');
var cors = require('cors');  
var authCtrl = require('./auth');
var middleware = require('./middleware');
var env = require('node-env-file');
var app = express();
env(__dirname + '/process.env');

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json())
app.use(express.static(__dirname + '/public'));
app.use(cors());  

// *** routes *** //
var routes = require('./routes/index.js');

// *** main routes *** //
app.use('/', routes);


module.exports = app;
