###
 cleand up Gruntfile based on:
 @link {http://www.thomasboyt.com/2013/09/01/maintainable-grunt.html}
 @module mystic-noggin
 @submodule Gruntfile
 @type {gruntfile}
###

###
  load all of the config files in tasks/ directory
  @private
  @module mystic-noggin
  @function loadConfig
  @param {string} path    - path to the directory that holds config objects
###
loadConfig = (path) ->
  glob = require 'glob'
  object = {}
  key = undefined

  glob.sync('*', {cwd: path}).forEach((option) ->
    key = option.replace(/\.coffee$/,'')
    object[key] = require(path + option)
  )
  return object

###
  main configuration for Grunt
  @main
###
module.exports = (grunt) ->
  appConfig = require './src/server/app-config'
  config =
    pkg: grunt.file.readJSON('package.json')
    serverConfig: require './src/server/app-config'
    env: process.env

  grunt.util._.extend(config, loadConfig('./tasks/options/'))
  grunt.initConfig(config)

  require('load-grunt-tasks')(grunt)

  grunt.loadTasks "tasks"
