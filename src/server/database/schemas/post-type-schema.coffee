###
  PostType Schema for the PostType table in the database.
  @module mystic-noggin
  @submodule server/database/schemas/post-type-schema
  @requires {module} mongoose
  @requires {module} bluebird
  @requires {submodule} server/logger
###
mongoose = require('mongoose')
P = require('bluebird')
logger = require('../../logger').logger

###
  The model for PostTypes. This can
  be assumed to be set because
  load() should be called on startup.
  @type {object} model
###
module.exports.model = {}

###
  The schema for PostTypes. This can
  be assumed to be set because
  load() should be called on app startup.
  @type {object} schema
###
module.exports.schema = {}

###
  Load up this schema and set the model.
  This should be called while the app is
  starting up (in ./_bootstrap.load())
  @function load
  @return {void}
###
module.exports.load = ->
  Schema = mongoose.Schema

  ###
    @schema PostType
    @param {string,required} name
    @param {number,default=0} usage
  ###
  module.exports.schema = postTypeSchema = new Schema(
    name: { type: String, required: true, unique: true }
    usage: { type: Number, default: 0 }
  )

  PostType = mongoose.model('PostType', postTypeSchema)
  P.promisifyAll(PostType)
  P.promisifyAll(PostType.prototype)

  module.exports.model = PostType

  logger.debug 'loaded PostType model into mongoose'
