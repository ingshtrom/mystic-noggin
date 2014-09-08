/**
 * Post Schema for the Post table in the database.
 *
 * @module mystic-noggin
 * @submodule server/database/schemas/post-schema
 * @public
 * @requires {module} mongoose
 * @requires {submodule} server/database/schemas/tag-schema
 * @requires {submodule} server/database/schemas/type-schema
 */
var mongoose = require('mongoose'),
    tagsSchema = require('./tag-schema').schema,
    postTypeSchema = require('./post-type-schema').schema;

/**
 * The model for Posts. This can
 * be assumed to be set because
 * load() should be called on startup.
 *
 * @type {object}
 * @public
 */
module.exports.model = {};

/**
 * The schema for Posts. This can
 * be assumed to be set because
 * load() should be called on app startup.
 *
 * @type {object}
 * @public
 */
module.exports.schema = {};

/**
 * Load up this schema and set the model.
 * This should be called while the app is
 * starting up (in ./_bootstrap.load())
 *
 * @public
 * @function load
 * @return {void}
 */
module.exports.load = function() {
  var Schema = mongoose.Schema;

  module.exports.schema = postSchema = new Schema({
    title: String,
    created: Date,
    updated: Date,
    content: String,
    type: postTypeSchema,
    tags: [tagsSchema]
  });

  module.exports.model = mongoose.model('Post', postSchema);
};
