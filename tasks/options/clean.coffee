###
  configuration for "clean" tasks
  @module mystic-noggin
  @submodule Gruntfile
  @task clean
  @requires {submodule} server/app-config
###
module.exports =
  logs: ["<%= serverConfig.logger.logDir %>"]
  build: ["<%= gruntConfig.pubDir %>", "<%= gruntConfig.testOutDir %>"]
