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
    logger = require('../logger').logger;

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
    _loadModels();
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
 * loads all models for all mongoose schemas
 * @function _loadModels
 * @return {void}
 */
var _loadModels = function() {
  var applyCb = function(schemaSMObj) {
    // NOTE (Alex.Hokanson): this assumes that all schema submodule
    // implements the load() function.  I'm not sure of how to enforce
    // this since Javascrip is such a dynamic language.
    if (typeof schemaSMObj.load === 'function') {
      schemaSMObj.load();
      logger.db.info('schema loaded into mongoose: ' + schemaSMObj.id);
    } else {
      logger.db.error('error loading schema for ' + schemaName);
    }
  };
  var resultCb = function(err) {
    if (err) {
      logger.db.error('Error loading a schema: ' + err);
    }
  };

  async.eachSeries(_getSchemas(), applyCb, resultCb);
};

/**
 * Look for all submodules within the schema/ directory
 * and load them into an array
 *
 * @function_getSchemas
 * @private
 * @return {submodule[]}
 */
var _getSchemas = function() {
  var schemaDirName = 'schemas',
      schemasDir = path.resolve(__dirname, schemaDirName),
      schemas = fs.readdirSync(schemasDir);
  return _(schemas).each(function(schemaPath) {
    var schemaName = path.basename(schemaPath, '.js');
    return require('./' + schemaDirName + '/' + schemaName);
  });
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
