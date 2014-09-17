###
  Configure custom loggers.
  @module mystic-noggin
  @submodule test/logger
  @requires {module} winston
  @requires {submodule} test/server/app-config
###
winston = require 'winston'
config = require './app-config'

setup = ->
  consoleConfig =
    level: config.logger.logLevel
    handleExceptions: true
    colorize: true
    timestamp: true

  fileConfig =
    filename: config.logger.defaultLogFile
    level: config.logger.logLevel
    maxsize: config.logger.maxFileSize
    handleExceptions: true

  myLoggers = {}
  myLoggers.main = new winston.Logger
    transports: [
      new winston.transports.Console consoleConfig
      new winston.transports.File fileConfig
    ]
    exitOnError: false

  return myLoggers

###
  A 'winston' instance that is
  customized for the current app.
  @type {object}
###
module.exports.logger = setup()
