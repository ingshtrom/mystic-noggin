###
 * The bootstrapping for connecting to the MongoDB database.
 * @module mystic-noggin
 * @submodule server/database/connection
 * @requires {module} mongoose
 * @requires {module} async
 * @requires {module} fs
 * @requires {module} path
 * @requires {submodule} server/app-config
 * @requires {submodules} server/logger
###
mongoose = require('mongoose')
async = require('async')
fs = require('fs')
path = require('path')
appConfig = require('../app-config')
logger = require('../logger').logger
schemas = require('./schemas')

###
 * Whether or not the database connection is open
 * @type {Boolean}
 * @private
###
isOpen = false

###
 * Start a connection to the MongoDB database
 * @function start
 * @return {void}
###
module.exports.start = ->
  dbUri = _buildConnectionString()
  options = _generateOptionsObj()

  # early return in case the connection is already open
  return mongoose.connection if mongoose.connection.readyState == 1 || mongoose.connection.readyState == 2

  logger.db.silly 'going to load schemas',
    conn: mongoose.connection.readyState

  schemas.load()

  mongoose.connect(dbUri, options)

  mongoose.connection.on('error', logger.db.error.bind(logger.db, 'mongodb error: '))
  mongoose.connection.once('close', ->
    isOpen = false
    logger.db.info('connection with mongodb server closed.')
  )
  mongoose.connection.once('open', ->
    isOpen = true
    logger.db.info('connection with mongodb server established.')
  )

  return mongoose.connection

###
 * Close the connection now!
 * @function close
 * @public
 * @return {void}
###
module.exports.close = ->
  mongoose.connection.close()

###
 * Generate and return an options {object} that
 * can be passed directly to mongoose.connect()
 * @function _generateOptionsObj
 * @private
 * @return {object}
###
_generateOptionsObj = ->
  options =
    server:
      auto_reconnect: true
      poolSize: 1
    replset: {}
    user: appConfig.database.user
    pass: appConfig.database.pass

  options.server.socketOptions = options.replset.socketOptions = { keepAlive: 1 }
  return options

###
 * Builds and returns a string that can be passed
 * to mongoose.connect
 * @function _buildConnectionString
 * @private
 * @return {string} - mongoose connection string
###
_buildConnectionString = ->
  conString = "mongodb://"
  conString += appConfig.database.serverName
  conString += ":#{appConfig.database.port}"
  conString += "/#{appConfig.database.dbName}"
  return conString
