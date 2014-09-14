###
 * PostType Schema for the PostType table in the database.
 * @module mystic-noggin
 * @submodule server/database/schemas/post-type-schema
 * @requires {module} mongoose
###
mongoose = require('mongoose')

###
 * The model for PostTypes. This can
 * be assumed to be set because
 * load() should be called on startup.
 * @type {object}
###
module.exports.model = {}

###
 * The schema for PostTypes. This can
 * be assumed to be set because
 * load() should be called on app startup.
 * @type {object}
###
module.exports.schema = {}

###
 * Load up this schema and set the model.
 * This should be called while the app is
 * starting up (in ./_bootstrap.load())
 * @function load
 * @return {void}
###
module.exports.load = ->
  Schema = mongoose.Schema

  ###
    @schema PostType
    @param {string,required} name
    @param {number,default=0} usage
  ###
  module.exports.schema = postTypeSchema = new Schema(
    name: { type: String, required: true }
    usage: { type: Number, default: 0 }
  )

  module.exports.model = mongoose.model('PostType', postTypeSchema)
