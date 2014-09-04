var Hapi = require('hapi'),
    logger = require('./logger').logger,
    config = require('./app-config'),
    routeConfig = require('./hapi-route-config').config,
    packConfig = require('./hapi-pack-config').config;

var server = new Hapi.Server(config.server.port);
server = routeConfig(server);
server = packConfig(server);
server.start(function () {
    logger.misc.debug('Server running at:', server.info.uri);
});
