###
 * Post Schema for the Post table in the database.
 * @module mystic-noggin
 * @submodule server/database/schemas/post-schema
 * @requires {module} mongoose
 * @requires {module} bluebird
 * @requires {submodule} server/database/schemas/tag-schema
 * @requires {submodule} server/database/schemas/post-type-schema
 * @requires {submodule} server/database/schemas/user-schema
###
mongoose = require('mongoose')
P = require 'bluebird'
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
    title: { type: String, unique: true }
    author: { type: Schema.Types.ObjectId, ref: 'User', require: true }
    created: { type: Date, default: Date.now }
    updated: { type: Date, default: Date.now }
    content: { type: String, required: true, unique: true }
    type: { type: Schema.Types.ObjectId, ref: 'PostType', required: true }
    tags: [{ type: Schema.Types.ObjectId, ref: 'Tag' }]
    comments: [
      body: { type: String, required: true }
      date: { type: Date, default: Date.now }
      name: { type: String, default: 'Anonymous' }
    ]
  )

  Post = mongoose.model('Post', postSchema)
  P.promisifyAll(Post)
  P.promisifyAll(Post.prototype)

  module.exports.model = Post

  logger.debug 'loaded Post model into mongoose'
