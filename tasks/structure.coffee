module.exports = (grunt) ->
  grunt.registerTask "create-struct",
    -> grunt.file.mkdir(grunt.config("serverConfig.logger.logDir"))
