###
  Bootstrap all API config together
  @module mystic-noggin
  @submodule server/api
  @requires {submodule} server/api/tags
###
tags = require './tags'

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
    path: '/'
    handler: (request, reply) ->
      reply('FOOBAR!')

  tags.config(server)

  return server
