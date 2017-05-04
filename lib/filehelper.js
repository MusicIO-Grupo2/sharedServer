// Decoding base-64 image
// Source: http://stackoverflow.com/questions/20267939/nodejs-write-base64-image-file
function decodeBase64Image(dataString) 
{
  var matches = dataString.match(/^data:([A-Za-z-+\/]+);base64,(.+)$/);
  var response = {};

  response.type = matches[1];
  response.data = new Buffer(matches[2], 'base64');

  return response;
}

function base64_encode(userUploadedImagePath) {
    var rutaSave = require("path").resolve("./img/upload") + "/";
    var image = require('fs').readFileSync(rutaSave+userUploadedImagePath);
    return new Buffer(image).toString('base64');
}
function generateImage(base64Image) {
	var imageTypeRegularExpression      = /\/(.*?)$/;      
	var crypto                          = require('crypto');
	var seed                            = crypto.randomBytes(20);
	var uniqueSHA1String                = crypto.createHash('sha1').update(seed).digest('hex');
	var imageBuffer                     = decodeBase64Image(base64Image);
	var rutaSave 			    = require("path").resolve("./img/upload") + "/";
	var uniqueRandomImageName           = 'image-' + uniqueSHA1String;
	var imageTypeDetected               = imageBuffer.type.match(imageTypeRegularExpression);
	var userUploadedImagePath           = rutaSave + uniqueRandomImageName +'.' + imageTypeDetected[1];

	require('fs').writeFileSync(userUploadedImagePath, imageBuffer.data);
	
	return  uniqueRandomImageName +'.' + imageTypeDetected[1];

}

module.exports = {
  'generateImageFromBase64': generateImage,
  'encodeImageFromFile':base64_encode,
};
