db = require '../../build/server/database/connection'
post = require '../../build/server/database/schemas/post-schema'
postType = require '../../build/server/database/schemas/post-type-schema'
tag = require '../../build/server/database/schemas/tag-schema'
user = require '../../build/server/database/schemas/user-schema'
test = require './index'
B = require('bluebird')
logger = test.logger

Tag = undefined
PostType = undefined
User = undefined
Post = undefined

removeTagAsync = ->
  new B((resolve, reject) ->
    Tag.removeAsync()
      .then ->
        logger.debug('Tag collection removed!')
        resolve()
      .catch (err) ->
        logger.error('Error removing Tag collection :: ', { error: err })
        reject(err))

removePostTypeAsync = ->
  new B((resolve, reject) ->
    PostType.removeAsync()
      .then ->
        logger.debug('PostType collection removed!')
        resolve()
      .catch (err) ->
        logger.error('Error removing PostType collection :: ', { error: err })
        reject(err))

removeUserAsync = ->
  new B((resolve, reject) ->
    User.removeAsync()
      .then ->
        logger.debug('User collection removed!')
        resolve()
      .catch (err) ->
        logger.error('Error removing User collection :: ', { error: err })
        reject(err))

removePostAsync = ->
  new B((resolve, reject) ->
    Post.removeAsync()
      .then ->
        logger.debug('Post collection removed!')
        resolve()
      .catch (err) ->
        logger.error('Error removing Post collection :: ', { error: err })
        reject(err))

tags = []
postTypes = []
users = []

createTagsAsync = ->
  new B((resolve, reject)->
    for i in [1..50]
      cur = i
      tmp = new Tag()
      tmp.name = "tag#{cur}"
      tags.push tmp
      tmp.saveAsync()
        .then (doc) ->
          logger.debug('created tag :: ' + doc[0].name)
          if cur == 50 then resolve()
        .catch (err) ->
          logger.error('failed to create tag :: ' + err)
          reject(err))

createPostTypesAsync = ->
  new B((resolve, reject) ->
    for i in [1..50]
      cur = i
      tmp = new PostType()
      tmp.name = "postType#{cur}"
      postTypes.push tmp
      tmp.saveAsync()
        .then (doc) ->
          logger.debug('created post type :: ' + doc[0].name)
          if cur == 50 then resolve()
        .catch (err) ->
          logger.error('failed to create post type :: ' + err)
          reject(err))

createUsersAsync = ->
  new B((resolve, reject) ->
    for i in [1..50]
      cur = i
      tmp = new User()
      tmp.username = "user#{cur}"
      tmp.password = '1234'
      tmp.meta.firstName = "bob#{cur}"
      tmp.meta.lastName = "linquist#{cur}"
      tmp.meta.email = "foobar#{cur}@baz.boo"
      users.push tmp
      logger.silly("pushing #{cur} is " + tmp)
      tmp.saveAsync()
        .then (doc) ->
          logger.debug('created user :: ' + doc[0].username)
          if cur == 50 then resolve()
        .catch (err) ->
          logger.error('failed to create user :: ' + err )
          reject(err))

createPostsAsync = ->
  new B((resolve, reject) ->
    for i in [1..50]
      cur = i
      tmp = new Post()
      tmp.title = "post#{cur}"
      logger.silly("user #{cur} is " + users[cur])
      tmp.author = users[cur]._id # TODO: we are not setting user1 for some reason, so on the 50th iteration we get undefined
      tmp.tags = [tags[cur]._id]
      tmp.type = postTypes[cur]._id
      tmp.content = "content biatch#{cur}"
      tmp.comments = []
      tmp.saveAsync()
        .then (doc) ->
          logger.debug('created post :: ' + doc[0].title)
          if cur == 50 then resolve()
        .catch (err) ->
          logger.error('failed to create post :: ' + err)
          reject(err))

module.exports.run = ->
  db.start()

  Tag = tag.model
  B.promisifyAll(Tag)
  B.promisifyAll(Tag.prototype)

  PostType = postType.model
  B.promisifyAll(PostType)
  B.promisifyAll(PostType.prototype)

  User = user.model
  B.promisifyAll(User)
  B.promisifyAll(User.prototype)

  Post = post.model
  B.promisifyAll(Post)
  B.promisifyAll(Post.prototype)

  removeTagAsync()
    .then -> removePostTypeAsync()
    .then -> removeUserAsync()
    .then -> removePostAsync()
    .then -> createTagsAsync()
    .then -> createPostTypesAsync()
    .then -> createUsersAsync()
    .then -> createPostsAsync()
    .then ->
      db.close()
      resolve()
    .catch (err) ->
      logger.error('Undefined error running db-reset :: ' + err )
      reject(err)

module.exports.runAsync = B.promisify(module.exports.run)
