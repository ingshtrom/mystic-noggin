###
  Configure custom loggers.
  @module mystic-noggin
  @submodule server/logger
  @requires {module} winston
  @requires {submodule} server/app-config
###
winston = require('winston')
config = require('./app-config')

setup = ->
  # add our custom transports for all loggers
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

  # define different loggers... aka categories
  # by providing this custom namespace, we have
  # easy accessors to all of our custom loggers!
  #
  # We don't want to make the loggers global because
  # the testing code needs to have custom loggers,
  # which would conflict with the global loggers
  myLoggers = {}
  myLoggers.api = new winston.Logger
    transports: [
      new winston.transports.Console consoleConfig
      new winston.transports.File fileConfig
    ]
    exitOnError: false

  myLoggers.db = new winston.Logger
    transports: [
      new winston.transports.Console consoleConfig
      new winston.transports.File fileConfig
    ]
    exitOnError: false

  myLoggers.misc = new winston.Logger
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
