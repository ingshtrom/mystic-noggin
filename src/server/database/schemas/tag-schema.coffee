###
  Tag Schema for the Tag table in the database.
  @module mystic-noggin
  @submodule server/database/schemas/tag-schema
  @requires {module} mongoose
  @requires {module} bluebird
  @requires {submodule} server/logger
###
mongoose = require('mongoose')
P = require('bluebird')
logger = require('../../logger').logger

###
  The model for Tags. This can
  be assumed to be set because
  load() should be called on startup.
  @type {object}
###
module.exports.model = {}

###
  The schema for Tags. This can
  be assumed to be set because
  load() should be called on app startup.
  @type {object}
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
    @schema Tag
    @param {string,required} name     - name of the the tag
    @param {number,default=0} usage  - the number of posts this Tag is used in
  ###
  module.exports.schema = tagSchema = new Schema(
    name: { type: String, required: true, unique: true }
    usage: { type: Number, default: 0 }
  )

  Tag = mongoose.model('Tag', tagSchema)
  P.promisifyAll(Tag)
  P.promisifyAll(Tag.prototype)

  module.exports.model = Tag

  logger.debug 'loaded Tag model into mongoose'
