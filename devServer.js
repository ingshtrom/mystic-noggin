// for use in grunt-hapi module in combination with grunt-contrib-coffee
var Hapi = require('hapi'),
    routeConfig = require('./build/server/api/_index').config,
    packConfig = require('./build/server/hapi-pack-config').config;

module.exports = function() {
  var server = new Hapi.Server(1234);
  server = routeConfig(server);
  server = packConfig(server);
  return server;
};
