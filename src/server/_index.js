var Hapi = require('hapi');
var server = new Hapi.Server();

server.start(function () {
    console.log('Server running at:', server.info.uri);
});
