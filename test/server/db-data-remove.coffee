db = require '../../build/server/database/connection'
post = require '../../build/server/database/schemas/post-schema'
postType = require '../../build/server/database/schemas/post-type-schema'
tag = require '../../build/server/database/schemas/tag-schema'
user = require '../../build/server/database/schemas/user-schema'
test = require './index'
P = require('bluebird')
logger = test.logger
didCallDirectly = require.main == module ? true : false

conn = db.start()

run = (resolve, reject) ->
  cb = ->
    Tag = tag.model
    PostType = postType.model
    User = user.model
    Post = post.model

    removeTagAsync = new P (resolve, reject) ->
      Tag.remove()
        .then ->
          logger.debug('Tag collection removed!')
          resolve()
        .catch (err) ->
          logger.error('Error removing Tag collection :: ', { error: err })
          reject()

    removePostTypeAsync = new P (resolve, reject) ->
      PostType.remove()
        .then ->
          logger.debug('PostType collection removed!')
          resolve()
        .catch (err) ->
          logger.error('Error removing PostType collection :: ', { error: err })
          reject()

    removeUserAsync = new P (resolve, reject) ->
      User.remove()
        .then ->
          logger.debug('User collection removed!')
          resolve()
        .catch (err) ->
          logger.error('Error removing User collection :: ', { error: err })
          reject()

    removePostAsync = new P (resolve, reject) ->
    Post.remove()
      .then ->
        logger.debug('Post collection removed!')
        resolve()
      .catch (err) ->
        logger.error('Error removing Post collection :: ', { error: err })
      .finally -> db.close()

    removeTagAsync()
      .then removePostTypeAsync
      .then removeUserAsync
      .then removePost
      .catch (err) -> logger.error('Undefined error :: ', { error: err })

  if conn?.readyState == 1 then cb()
  else conn.on 'connected', cb

module.exports.runAsync = runAsync = new P(run)

if didCallDirectly
  runAsync()
    .catch (err) -> logger.err('Error: %j', err)
