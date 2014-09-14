###
  Bootstrap all API config together
  @module mystic-noggin
  @submodule server/api
###

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

  return server
