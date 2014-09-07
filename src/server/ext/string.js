/**
 * Custom {string} extensions.
 * Apply them by calling .extend()
 *
 * @module mystic-noggin
 * @submodule server/ext/string
 * @public
 */

/**
 * Load all {string}.prototype extensions
 *
 * @func extend
 * @public
 * @return {void}
 */
modules.exports.extend = function() {
  if (typeof String.prototype.endsWith !== "function") {
    String.prototype.endsWith = function(suffix) {
      return this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
  }
};
