chai = require 'chai'
expect = chai.expect
counter = require 'chai-counter'
request = require 'request'
config = require '../app-config'
logger = require('../logger').logger
async = require 'async'

describe 'Tag Schema', ->
  describe 'GET /api/tags', ->
    url = "#{config.testData.baseUrl}/api/tags"
    before (done) ->
      this.timeout(10000)
      arr = [
        '../db-data-remove'
        '../db-data-gen'
      ]
      async.eachSeries arr,
        (it, cb) ->
          require it
        ->
          logger.main.silly 'donezone'
          done()

    # it 'should return objects with correct properties', ->
    #   # expect 'name' and 'usage' properties

    it 'should return all tags without parameters', (done) ->
      # expect 10 tags
      counter.expect(1)
      request url, (err, res, body) ->
        logger.main.debug "requested #{url}",
          err: err
          res: res
          body: body
        counter.assert()
        done()

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

    it 'should return only names when using filter parameter', ->
      # expect 10 tags with only the name property (not usage)
      expect(2).to.equal(1)
