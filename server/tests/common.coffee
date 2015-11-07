Promise = require('bluebird')
server = require('../app')

p = new Promise (resolve, reject) ->
  server.ext 'onPostStart', ->
    resolve(server)

module.exports = p