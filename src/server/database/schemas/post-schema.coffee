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
userSchema = require('./user-schema').schema
logger = require('../../logger').logger

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

  ###
    @schema Post
    @param {string}                     title
    @param {objectid,required}          author            - see (server/database/schemas/user-schema)
    @param {date,default=Date.now}      created
    @param {date,default=Date.now}      updated
    @param {string,required}            content
    @param {objectid,required}          type              - see (server/database/schemas/post-schema)
    @param {[objectid]}                 tags              - see (server/database/schemas/tag-schema)
    @param {[document]}                 comments
    @param {string,required}            comments.body
    @param {date,default=Date.now}      comments.date
    @param {string,default="Anonymous"} comments.name
  ###
  module.exports.schema = postSchema = new Schema(
    title: String
    author: { type: Schema.Types.ObjectId, require: true }    # user-schema
    created: { type: Date, default: Date.now }
    updated: { type: Date, default: Date.now }
    content: { type: String, required: true }
    type: { type: Schema.Types.ObjectId, required: true }     # post-type-schema
    tags: [Schema.Types.ObjectId]                             # tag-schema
    comments: [{
      body: { type: String, required: true }
      date: { type: Date, default: Date.now }
      name: { type: String, default: 'Anonymous' }
    }]
  )

  module.exports.model = mongoose.model('Post', postSchema)

  logger.db.debug 'loaded Post model into mongoose'
