###
  @module mystic-noggin
  @submodule hapi-server
  @public
  @requires {module} hapi
  @requires {submodule} server/logger
  @requires {submodule} server/app-config
  @requires {submodule} server/api
  @requires {submodule} server/hapi-pack-config
###
Hapi = require('hapi')
logger = require('./logger').logger
config = require('./app-config')
routeConfig = require('./api/_index').config
packConfig = require('./hapi-pack-config').config

###
  Start the Hapi server
  @method start
  @public
  @return {void}
###
module.exports.start = ->
  server = new Hapi.Server(config.server.port)
  server = routeConfig(server)
  server = packConfig(server)
  server.start -> logger.misc.debug('Server running at:', server.info.uri)
