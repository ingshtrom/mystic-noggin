db = require '../../build/server/database/connection'
post = require '../../build/server/database/schemas/post-schema'
postType = require '../../build/server/database/schemas/post-type-schema'
tag = require '../../build/server/database/schemas/tag-schema'
user = require '../../build/server/database/schemas/user-schema'
logger = require('./logger').logger
async = require 'async'
didCallDirectly = require.main == module ? true : false

conn = db.start()

run = (callback) ->
  cb = ->
    Tag = tag.model
    Post = post.model
    PostType = postType.model
    User = user.model

    tags = []
    postTypes = []
    users = []

    createTags = ->
      for i in [1..50]
        tmp = new Tag()
        tmp.name = "tag#{i}"
        tags.push tmp
        tmp.save (err, doc) ->
          if err
            logger.main.error('failed to create tag: %j', err)
          else
            logger.main.debug('created tag: %j', doc.name)

    createPostTypes = ->
      for i in [1..50]
        tmp = new PostType()
        tmp.name = "postType#{i}"
        postTypes.push tmp
        tmp.save (err, doc) ->
          if err
            logger.main.error('failed to create post type: %j', err)
          else
            logger.main.debug('created post type: %j', doc.name)

    createUsers = ->
      for i in [1..50]
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

    createPosts = ->
      for i in [1..50]
        console.info(users[i])
        tmp = new Post()
        tmp.title = "post#{i}"
        tmp.author = users[i]._id # TODO: we are not setting user1 for some reason, so on the 50th iteration we get undefined
        tmp.tags = [tags[i]._id]
        tmp.type = postTypes[i]._id
        tmp.content = "content biatch#{i}"
        tmp.comments = []
        tmp.save (err, doc) ->
          if err
            logger.main.error('failed to create post: %j', err)
          else
            logger.main.debug('created post: %j', doc.title)

    createTags()
    createPostTypes()
    createUsers()
    setTimeout createPosts, 1000
    setTimeout(
      ->
        db.close()
        callback?()
      2000
    )

  if conn?.readyState == 1 then cb()
  else conn.on 'connected', cb

module.exports.run = run

run() if didCallDirectly
