###
 * User Schema for the User table in the database.
 * @module mystic-noggin
 * @submodule server/database/schemas/user-schema
 * @requires {module} mongoose
###
mongoose = require('mongoose')

###
 * The model for Users. This can
 * be assumed to be set because
 * load() should be called on startup.
 * @type {object}
###
module.exports.model = {}

###
 * The schema for Users. This can
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
    @schema User
    @param {string,required} username
    @param {string,required} password
    @param {string} meta.firstname
    @param {string} meta.lastname
    @param {string} meta.email
  ###
  module.exports.schema = userSchema = new Schema(
    username: { type: String, required: true }
    password: { type: String, required: true }
    meta: {
      firstName: String
      lastName: String
      email: String
    }
  )

  module.exports.model = mongoose.model('User', userSchema)
