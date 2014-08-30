module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json')
  });

  grunt.registerTask("create-struct", function() {
    var config = require('./src/server/app-config');
    grunt.file.mkdir(config.logger.logDir);
  });
};
