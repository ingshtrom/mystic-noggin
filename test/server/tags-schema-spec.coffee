chai = require 'chai'
expect = chai.expect
counter = require 'chai-counter'
req = require 'request'

describe 'Tag Schema', ->
  describe 'GET /api/tags', ->
    beforeAll ->
      # setup the database with 10 tags
    it 'should return all tags without parameters', ->
      # expect 10 tags
    it 'should return only 5 tags with limit parameter', ->
      # expect 5 tags
    it 'should return only names when using filter parameter', ->
      # expect 10 tags with only the name property (not usage)
