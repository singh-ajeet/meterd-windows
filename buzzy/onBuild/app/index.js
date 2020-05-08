// index.js
var express = require('express');
var ip = require('ip');
var app = express();
app.set('port', (process.env.PORT || 8675));
app.use(express.static(__dirname + '/public'));
app.get('/', function(request, response) {
	response.send("Hello World! (from " + ip.address() + ":" + app.get('port') + ")");
});
app.get('/*', function(request, response) {
	var fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
	response.send("Hello "+fullUrl+"! (from " + ip.address() + ":" + app.get('port') + ")");
});
app.listen(app.get('port'), function() {
	console.log("Node app is running at " + ip.address() +":" + app.get('port'));
});