var Hapi = require('hapi'),
    logger = require('./logger'),
    config = require('./app-config'),
    routeConfig = require('./hapi-route-config'),
    packConfig = require('./hapi-pack-config');

var server = new Hapi.Server(config.server.port);
server = routeConfig(server);
server = packConfig(server);
server.start(function () {
    logger.info('Server running at:', server.info.uri);
});
