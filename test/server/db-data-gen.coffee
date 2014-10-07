db = require '../../build/server/database/connection'
post = require '../../build/server/database/schemas/post-schema'
postType = require '../../build/server/database/schemas/post-type-schema'
tag = require '../../build/server/database/schemas/tag-schema'
user = require '../../build/server/database/schemas/user-schema'
test = require './index'
logger = test.logger
async = require 'async'
P = require 'bluebird'
didCallDirectly = require.main == module ? true : false

conn = db.start()

run = (resolve, reject) ->
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
        tmp.saveAsync()
          .then (doc) ->
            logger.debug('created tag: %j', doc.name)
          .catch (err) ->
              logger.error('failed to create tag :: ', { error: err })
    createTagsAsync = P.promisify(createTags);

    createPostTypes = ->
      for i in [1..50]
        tmp = new PostType()
        tmp.name = "postType#{i}"
        postTypes.push tmp
        tmp.saveAsync()
          .then (doc) ->
            logger.debug('created post type: %j', doc.name)
          .catch (err) ->
            logger.error('failed to create post type :: ', { error: err })
    createPostTypesAsync = P.promisify(createPostTypes)

    createUsers = ->
      for i in [1..50]
        tmp = new User()
        tmp.username = "user#{i}"
        tmp.password = '1234'
        tmp.meta.firstName = "bob#{i}"
        tmp.meta.lastName = "linquist#{i}"
        tmp.meta.email = "foobar#{i}@baz.boo"
        users.push tmp
        tmp.saveAsync()
          .then (doc) ->
            logger.debug('created user: %j', doc.username)
          .catch (err) ->
            logger.error('failed to create user :: ', { error: err })
    createUsersAsync = P.promisify(createUsers)

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
        tmp.saveAsync()
          .then (doc) ->
            logger.debug('created post: %j', doc.title)
          .catch (err) ->
            logger.error('failed to create post :: ', { error: err })
    createPostsAsync = P.promisify(createPosts)

    createTagsAsync()
      .then createPostTypesAsync
      .then createUsersAsync
      .then createPostsAsync
      .then ->
        resolve()
      .catch (err) ->
        logger.error('Unidentified error while generating test data :: ', { error: err })
        reject()
      .finally -> db.close()

  if conn?.readyState == 1 then cb()
  else conn.on 'connected', cb

module.exports.runAsync = runAsync = new P(run)

if didCallDirectly
  runAsync()
    .catch (err) -> logger.error('Error :: ', { error: err })
