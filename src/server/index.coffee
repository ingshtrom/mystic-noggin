###
  Bootstrapping submodule for the server.
  @module mystic-noggin
  @submodule server
  @public
  @requires {submodule} server/app-config
  @requires {submodule} server/logger
  @requires {submodule} server/hapi-server
  @requires {submodule} server/database/connection
###
config = require('./app-config')
logger = require('./logger').logger
server = require('./hapi-server')
database = require('./database/connection')

module.exports = ->
  myHapi = server.start()
  database.start()

  logger.debug('///////////////////////////////')
  logger.debug('///////    Config...    ///////')
  logger.debug('.app => ', config.app)
  logger.debug('.server => ', config.server)
  logger.debug('.logger => ', config.logger)
  logger.debug('.database => ', config.database)
  logger.debug('///////    ...Config    ///////')
  logger.debug('///////////////////////////////')

  return myHapi
