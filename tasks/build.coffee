###
  The defacto build command. It does it all!
  @module mystic-noggin
  @submodule Gruntfile
  @task build
###
module.exports = (grunt) ->
  grunt.registerTask "build", ->
    grunt.task.run [
      "clean"
      "coffeelint:app"
      "create-struct"
      "coffee"
    ]
