###
 Global Configuration for tests
 @module mystic-noggin
 @submodule test/server/app-config
 @requires {module} path
 @requires {submodule} serverConfig
###
path = require 'path'
serverConfig = require '../../build/server/app-config'

###
 Logger configuration
 @type {Object}
 @property {string} defaultLogFile  - The name of the default log file
 @property {string} logLevel        - ['silly','debug','verbose','info','warn','error']
 @property {number} maxFileSize     - maximum file size for log files before starting a new file
###
module.exports.logger =
  defaultLogFile: path.resolve(serverConfig.logger.logDir, "server_tests.log")
  logLevel: 'silly'
  maxFileSize: 102400

module.exports.testData =
  baseUrl: "http://localhost:#{serverConfig.server.port}"
