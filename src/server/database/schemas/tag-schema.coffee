###
 * Tag Schema for the Tag table in the database.
 * @module mystic-noggin
 * @submodule server/database/schemas/tag-schema
 * @requires {module} mongoose
###
mongoose = require('mongoose')

###
 * The model for Tags. This can
 * be assumed to be set because
 * load() should be called on startup.
 * @type {object}
###
module.exports.model = {}

###
 * The schema for Tags. This can
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

  module.exports.schema = tagSchema = new Schema(
    name: String
  )

  module.exports.model = mongoose.model('Tag', tagSchema)