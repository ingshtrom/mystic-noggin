db = require '../build/server/database/connection'
post = require '../build/server/database/schemas/post-schema'
postType = require '../build/server/database/schemas/post-type-schema'
tag = require '../build/server/database/schemas/tag-schema'
user = require '../build/server/database/schemas/user-schema'
timer = require 'timers'

db.start()
timer.setTimeout ->
  Tag = tag.model
  Post = post.model
  PostType = postType.model
  User = user.model

  for i in [0..9]
    tmp = new Tag()
    tmp.name = "tag#{i}"
    tmp.save (err) ->
      if err
        console.log('failed to create tag')
      else
        console.log('created tag')

  for i in [0..9]
    tmp = new PostType()
    tmp.name = "postType#{i}"
    # TODO fill out other data
    tmp.save (err) ->
      if err
        console.log('failed to create post type')
      else
        console.log('created post type')

  for i in [0..9]
    tmp = new User()
    tmp.name = "user#{i}"
    # TODO fill out other data
    tmp.save (err) ->
      if err
        console.log('failed to create user')
      else
        console.log('created user')

  for i in [0..9]
    tmp = new Post()
    tmp.name = "post#{i}"
    # TODO fill out other data
    tmp.save (err) ->
      if err
        console.log('failed to create post')
      else
        console.log('created post')
, 1000
