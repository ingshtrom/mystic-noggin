###
 * Post Schema for the Post table in the database.
 * @module mystic-noggin
 * @submodule server/database/schemas/post-schema
 * @requires {module} mongoose
 * @requires {submodule} server/database/schemas/tag-schema
 * @requires {submodule} server/database/schemas/post-type-schema
 * @requires {submodule} server/database/schemas/user-schema
###
mongoose = require('mongoose')
tagsSchema = require('./tag-schema').schema
postTypeSchema = require('./post-type-schema').schema
userSchema = require './user-schema' .schema

###
 * The model for Posts. This can
 * be assumed to be set because
 * load() should be called on startup.
 * @type {object}
###
module.exports.model = {}

###
 * The schema for Posts. This can
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

  module.exports.schema = postSchema = new Schema(
    title: String
    author: ObjectId  # user-schema
    created: { type: Date, default: Date.now }
    updated: { type: Date, default: Date.now }
    content: String
    type: ObjectId    # post-type-schema
    tags: [ObjectId]  # tag-schema
    comments: [{
      body: String
      date: { type: Date, default: Date.now }
      name: { type: String, default: 'Anonymous' }
    }]
  )

  module.exports.model = mongoose.model('Post', postSchema)
