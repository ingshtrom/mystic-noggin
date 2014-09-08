/**
 * The bootstrapping for connecting to the MongoDB database.
 *
 * @module mystic-noggin
 * @submodule server/database/connection
 * @public
 * @requires {module} mongoose
 * @requires {module} lodash
 * @requires {module} async
 * @requires {module} fs
 * @requires {module} path
 * @requires {submodule} server/app-config
 * @requires {submodules} server/logger
 */
var mongoose = require('mongoose'),
    _ = require('lodash'),
    async = require('async'),
    fs = require('fs'),
    path = require('path'),
    appConfig = require('../app-config'),
    logger = require('../logger').logger,
    schemas = require('./schemas/_bootstrap');

/**
 * Whether or not the database connection is open
 *
 * @type {Boolean}
 * @private
 */
var isOpen = false;

/**
 * Start a connection to the MongoDB database
 *
 * @function start
 * @return {void}
 */
module.exports.start = function() {
  var dbUri = _buildConnectionString(),
      options = _generateOptionsObj();

  mongoose.connect(dbUri, options);

  mongoose.connection.on('error', logger.db.error.bind(logger.db, 'mongodb error: '));
  mongoose.connection.once('close', function() {
    logger.db.info('connection with mongodb server closed.');
  });
  mongoose.connection.once('open', function() {
    logger.db.info('connection with mongodb server established.');
    isOpen = true;
    schemas.load();
  });
};

/**
 * Close the connection now!
 *
 * @function close
 * @public
 * @return {void}
 */
module.exports.close = function() {
  mongoose.connection.close();
  isOpen = false;
};

/**
 * Generate and return an options {object} that
 * can be passed directly to mongoose.connect()
 * @function_generateOptionsObj
 * @private
 * @return {object}
 */
var _generateOptionsObj = function() {
  var options = {
    server: {},
    replset: {}
  };

  options.server.socketOptions = options.replset.socketOptions = { keepAlive: 1 };
  options.user = appConfig.database.user;
  options.pass = appConfig.database.pass;
  return options;
};

/**
 * Builds and returns a string that can be passed
 * to mongoose.connect
 * @function_buildConnectionString
 * @private
 * @return {string} - mongoose connection string
 */
var _buildConnectionString = function() {
  var conString = "mongodb://";
  conString += appConfig.database.serverName;
  conString += ":" + appConfig.database.port;
  conString += "/" + appConfig.database.dbName;
  return conString;
};
