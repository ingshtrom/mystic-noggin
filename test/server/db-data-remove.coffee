db = require '../../build/server/database/connection'
post = require '../../build/server/database/schemas/post-schema'
postType = require '../../build/server/database/schemas/post-type-schema'
tag = require '../../build/server/database/schemas/tag-schema'
user = require '../../build/server/database/schemas/user-schema'
logger = require('./logger').logger
didCallDirectly = require.main == module ? true : false

module.exports.run = run = ->
  cb = ->
    Tag = tag.model
    PostType = postType.model
    User = user.model
    Post = post.model

    Tag.remove (err) ->
      if err then logger.main.error 'Error removing Tag collection ::', err
      else logger.main.debug 'Tag collection removed!'

    PostType.remove (err) ->
      if err then logger.main.error 'Error removing PostType collection: %j', err
      else logger.main.debug 'PostType collection removed!'

    User.remove (err) ->
      if err then logger.main.error 'Error removing User collection: %j', err
      else logger.main.debug 'User collection removed!'

    Post.remove (err) ->
      if err then logger.main.error 'Error removing Post collection: %j', err
      else logger.main.debug 'Post collection removed!'

    if didCallDirectly
      require('timers')
        .setTimeout(
          -> db.close(),
          5000
        )

  if didCallDirectly then conn = db.start()

  if conn.readyState == 1 then cb()
  else conn.on 'connected', cb

run()
