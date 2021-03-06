###
 Global Configuration for the app.
 @module mystic-noggin
 @submodule server/app-config
 @requires {module} path
###
path = require('path')

###
 General app configuration.
 @type {Object}
 @property {string} root            - the root of the mystic-noggin module
###
module.exports.app =
  root: path.resolve(__dirname, '../../')

###
 Server Configuration
 @type {Object}
 @property {number} port            - port that mystic-noggin listens on
###
module.exports.server =
  port: 3000

###
 The root for all logs.
 @private
 @type {string}
###
logRoot = path.resolve(module.exports.app.root, 'logs')

###
 Logger configuration
 @type {Object}
 @property {string} logRoot         - The root for all logs
 @property {string} defaultLogFile  - The name of the default log file
 @property {string} logLevel        - ['silly','debug','verbose','info','warn','error']
 @property {number} maxFileSize     - maximum file size for log files before starting a new file
###
module.exports.logger =
  logDir: logRoot
  defaultLogFile: path.resolve(logRoot, "mystic-noggin")
  logLevel: 'silly'
  maxFileSize: 102400

###
 Database configuration
 See http://mongoosejs.com/docs/connections.html
 for where many of these settings come from
 @type {object}
 @property {string} dbName          - name of the database
 @property {string} serverName      - name of the server hosting mongodb
 @property {string} user            - name of user to authenticate as
 @property {string} pass            - password to authenticate with
###
module.exports.database =
  dbName: 'mn_test'
  serverName: 'localhost'
  user: 'tester'
  pass: '1234'
