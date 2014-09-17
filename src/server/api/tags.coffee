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
    @api {GET} /api/tags
    @return {object[]}    - an array of tags objects
  ###
  server.route
    method: 'GET'
    path: '/api/tags'
    handler: (request, reply) ->
      reply(tags.model.find())
    config:
      description: 'Get tags'
      tags: ['api']
      notes: [
        'Get all tags.'
      ]
