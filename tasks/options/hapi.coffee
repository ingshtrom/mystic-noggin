###
  grunt-hapi config
  @module mystic-noggin
  @submodule Gruntfile
  @task hapi
  @requires {module} path
###
path = require 'path'

module.exports =
  custom_options:
    options:
      server: path.resolve './devServer'
      bases:
        '/src': path.resolve './src/server/'
        '/build': path.resolve './build/server'
