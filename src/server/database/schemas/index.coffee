###
  Bootstraps all schemas together into models.
  All schemas need to explicitly loaded here.
  @module mystic-noggin
  @submodule server/database/schemas
  @requires {module} async
  @requires {submodule} server/database/schemas/tag-schema
  @requires {submodule} server/database/schemas/post-type-schema
  @requires {submodule} server/database/schemas/user-schema
  @requires {submodule} server/database/schemas/post-schema
###
async = require 'async'
logger = require('../../logger').logger
schemas = [
  require './tag-schema'            # required by ./post-schema
  require './post-type-schema'      # required by ./post-schema
  require './user-schema'            # required by ./post-schema
  require './post-schema'
]

###
  Whether or not all of the schemas have been loaded.
  IIRC, we will get a bunch of funky behaviour when
  trying to load models multiple times.
  @type {Boolean}
  @private
###
module.exports.areLoaded = false

###
  Loads all schemas defined in the 'schemas' variable.
  @public
  @function load
  @return {void}
###
module.exports.load = ->
  loopFn = (schema) ->
    currentSchema = schema.id
    schema.load()
  errFn = (err) ->
    if err
      logger.error("There was an error loading #{currentSchema}: #{err}")
    else
      module.exports.areLoaded = true
      logger.info("Loaded schema: #{currentSchema}")
  async.each(schemas, loopFn, errFn)
