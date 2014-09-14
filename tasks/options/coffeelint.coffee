###
  configuration for "coffee-lint" tasks
  @module mystic-noggin
  @submodule Gruntfile
  @task coffee-lint
###
module.exports =
  options:
    configFile: 'coffeelint.json'
  app:  ['<%= gruntConfig.srcDir %>/**/*.coffee']
  tests:['<%= gruntConfig.testDir %>/**/*.coffee']
  grunt:['tasks/**/*.coffee']
