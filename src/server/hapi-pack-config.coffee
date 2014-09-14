###
  Configure any plugins or packs for the Hapi server
  @module mystic-noggin
  @submodule server/hapi-pack-config
  @requires {module} path
  @requires {submodule} server/app-config
###
path = require 'path'
config = require './app-config'

###
  Do the actual configuration specified by this module.
  @function config
  @param {object} server  - the hapi server object that the packs
                            will be attached to
  @return {object}        - hapi server object with packs attached
###
module.exports.config = (server) ->
  logFile = path.resolve(config.logger.logDir, "stats.log")
  # config Good server logging for Hapi
  options =
    broadcastInterval: 1000
    opsInterval: 60 * 1000
    maxLogSize: config.logger.maxFileSize
    subscribers:
      'console': ['ops', 'request', 'log', 'error']
  options.subscribers[logFile] = ['ops', 'request', 'log', 'error']

  server.pack.register({
    plugin: require('good')
    options: options
  },
  (err) ->
    if (err)
      logger.error("'Good' logger error: " + err)
      return
  )

  return server
