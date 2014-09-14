###
  Configure the /api/tags API interface
  @module mystic-noggin
  @submodule mg-api
###
tags = require '../database/schemas/tag-schema'

###
  Attach the ../tags endpoints to the Hapi server object
  @function config
  @param {object} server    - Hapi server instance
  @return {void}
###
module.exports.config = (server) ->
  ###
    Get all tags defined
  ###
  server.route
    method: 'GET'
    path: '/api/tags'
    handler: (request, reply) ->
      reply('FooBiz!')
