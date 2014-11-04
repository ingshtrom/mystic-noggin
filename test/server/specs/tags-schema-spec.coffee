chai = require 'chai'
expect = chai.expect
counter = require 'chai-counter'
request = require 'request'
test = require '../index'
config = test.config
logger = test.logger
async = require 'async'

before (done) ->
  require('../db-reset').runAsync()
    .then -> done()
    .catch (err) ->
      logger.error('Error during before function')
      logger.error('message: ' + err.message)
      logger.error('stack trace: ' + err.stack)

describe 'Tag Schema', ->
  describe 'GET /api/tags', ->
    url = "#{config.testData.baseUrl}/api/tags"

    it 'should return objects with correct properties', (done) ->
      # expect _id, name, and usage properties
      counter.expect(8)
      cb = (err, res, body) ->
        body = JSON.parse(body)
        expect(err).to.be.null.cc
        expect(body).to.be.an("object").cc
        expect(body).to.have.property("tags").cc
                    .and.is.an("array").cc
        expect(body.tags[0]).to.be.an("object").cc
        expect(body.tags[0]).to.have.property("_id").cc
        expect(body.tags[0]).to.have.property("name", "tag0").cc
        expect(body.tags[0]).to.have.property("usage", 0).cc
        counter.assert()
        done()
      request "#{url}?limit=1", cb

    it 'should return default # of tags without limit', (done) ->
      # expect 20 tags
      counter.expect(2)
      cb = (err, res, body) ->
        body = JSON.parse(body)
        expect(body.tags.length).to.be.a("number").cc
                                .and.equal(20).cc
        counter.assert()
        done()
      request url, cb

    it 'should return only 5 tags with limit parameter', (done) ->
      # expect 5 tags
      counter.expect(1)
      request "#{url}?limit=5", (err, res, body) ->
        logger.main.debug "requested #{url}",
          err: err
          res: res
          body: body
        counter.assert()
        done()
    #
    # it 'should return only names when using filter parameter', ->
    #   # expect 10 tags with only the name property (not usage)
    #   expect(2).to.equal(1)
