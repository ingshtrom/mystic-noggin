module.exports = function(grunt) {
  var pkgConfig = grunt.file.readJSON("package.json"),
      appConfig = require('./src/server/app-config');

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    appConfig: appConfig,
    clean: {
      logs: ['<%= appConfig.logger.logDir %>']
    }
  });

  for (var key in pkgConfig.devDependencies) {
    if (key !== "grunt" && key.indexOf("grunt") === 0) {
      grunt.log.writeln("loading grunt plugin: " + key);
      grunt.loadNpmTasks(key);
    }
  }

  grunt.registerTask("create-struct", function() {
    grunt.file.mkdir(appConfig.logger.logDir);
  });
};
