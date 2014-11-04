###
  Configure the /api/tags API interface
  @module mystic-noggin
  @submodule mg-api
  @requires {module} joi
  @requires {submodule} server/database/schemas/tag-schema
  @requires {submodule} server/logger
###
joi = require 'joi'
tags = require '../database/schemas/tag-schema'
logger = require('../logger').logger

_getTags = (request, reply) ->
  cb = (err, data) ->
    if err then reply({ err: 'Error finding tags.' }).code(400)
    else reply({ tags: data })

  tmpLimit = request.query.limit
  limit = if tmpLimit? then tmpLimit else 20
  tags.model
    .find({})
    .select('_id name usage')
    .limit(limit)
    .exec(cb)

###
  Attach the /api/tags endpoints to the Hapi server object
  @function config
  @param {object} server    - Hapi server instance
  @return {void}
###
module.exports.config = (server) ->
  server.route
    method: 'GET'
    path: '/api/tags'
    handler: _getTags
    config:
      description: 'Get tags'
      tags: ['api']
      notes: [
        'Get all tags.'
        'Error status codes'
        '400, Error finding tags'
        '500, Internal Server Error'
      ]
      validate:
        query:
          limit: joi.number().optional().min(0).max(100).description('limit the results returned. Default: 20; Max: 100;')
          # query: join.string().optional().description('query string. Not Implemented Yet.')
