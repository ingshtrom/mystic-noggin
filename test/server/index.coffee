module.exports.config = require './app-config'
module.exports.logger = require('../../build/server/logger').logger


# promisify all my libraries once!
B = require 'bluebird'

B.promisifyAll(require('mongoose'))
