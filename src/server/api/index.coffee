###
  Bootstrap all API config together
  @module mystic-noggin
  @submodule server/api
  @requires {submodule} server/api/tags
###
tags = require './tags'
joi  = require 'joi'

###
  Bootstrap and configure all API endpoints
  for the Hapi server.
  @function config
  @param  {object} server - Hapi server object
  @return {object}        - Hapi server object with configured API endpoints
###
module.exports.config = (server) ->
  server.route
    method: 'GET'
    path: '/test'
    handler: (req, reply) -> reply('FOOBAR')
    config:
      description: 'Test server'
      notes: 'Test that the server is up'
      tags: ['api']
  # server.route
  #   method: 'PUT'
  #   path: '/foobar/{a}'
  #   handler: (request, reply) ->
  #   config:
  #     description: 'Get todo'
  #     notes: 'Returns a todo item by the id passed in the path'
  #     tags: ['api']
  #     validate:
  #       params:
  #         a: joi.number().required().description('the id for the todo item')

  tags.config(server)

  return server
