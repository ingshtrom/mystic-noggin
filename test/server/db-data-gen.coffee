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
    Post = post.model
    PostType = postType.model
    User = user.model

    tags = []
    postTypes = []
    users = []

    for i in [0..9]
      tmp = new Tag()
      tmp.name = "tag#{i}"
      tags.push tmp
      tmp.save (err, doc) ->
        if err
          logger.main.error('failed to create tag: %j', err)
        else
          logger.main.debug('created tag: %j', doc.name)

    for i in [0..9]
      tmp = new PostType()
      tmp.name = "postType#{i}"
      postTypes.push tmp
      tmp.save (err, doc) ->
        if err
          logger.main.error('failed to create post type: %j', err)
        else
          logger.main.debug('created post type: %j', doc.name)

    for i in [0..9]
      tmp = new User()
      tmp.username = "user#{i}"
      tmp.password = '1234'
      tmp.meta.firstName = "bob#{i}"
      tmp.meta.lastName = "linquist#{i}"
      tmp.meta.email = "foobar#{i}@baz.boo"
      users.push tmp
      tmp.save (err, doc) ->
        if err
          logger.main.error('failed to create user: %j', err)
        else
          logger.main.debug('created user: %j', doc.username)

    for i in [0..9]
      tmp = new Post()
      tmp.title = "post#{i}"
      tmp.author = users[i]._id
      tmp.tags = [tags[i]._id]
      tmp.type = postTypes[i]._id
      tmp.content = "content biatch#{i}"
      tmp.comments = []
      tmp.save (err, doc) ->
        if err
          logger.main.error('failed to create post: %j', err)
        else
          logger.main.debug('created post: %j', doc.title)

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
