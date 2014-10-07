###
 Global Configuration for tests
 @module mystic-noggin
 @submodule test/server/app-config
 @requires {module} path
 @requires {submodule} serverConfig
###
path = require 'path'
serverConfig = require '../../build/server/app-config'

module.exports.testData =
  baseUrl: "http://localhost:#{serverConfig.server.port}"
