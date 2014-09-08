/**
 * Bootstraps all schemas together into models.
 * All schemas need to explicitly loaded here.
 *
 * @module mystic-noggin
 * @submodule server/database/schemas
 * @requires {module} async
 * @requires {submodule} post-schema
 */
var async = require('async'),
    schemas = [
      require('./tag-schema'),            // required by ./post-schema
      require('./post-type-schema'),      // required by ./post-schema 
      require('./post-schema')
    ];

/**
 * Whether or not all of the schemas have been loaded.
 * IIRC, we will get a bunch of funky behaviour when
 * trying to load models multiple times.
 *
 * @type {Boolean}
 * @private
 */
var areLoaded = false;

/**
 * Loads all schemas defined in the 'schemas' variable.
 *
 * @public
 * @function load
 * @return {void}
 */
module.exports.load = function() {
  var currentSchema;
  async.each(
    schemas,
    function(schema) {
      currentSchema = schema.id;
      schema.load();
    },
    function(err) {
      if (err) {
        logger.db.error('There was an error loading ' + currentSchema + ': ' + err);
      } else {
        areLoaded = true;
        logger.db.info('Loaded schema: ' + currentSchema);
      }
    }
  );
};
