# turn code coverage off since this is part of the testing harness
Promise = require('bluebird')
require('mockgoose')(require('mongoose'))
server = require('../app')
expect = require('chai').expect

internals = {}

internals.serverPromise = new Promise (resolve, reject) ->
  # server.start invokes an onPostStart extension. Only one onPostStart extension
  # seems to be called, so we'll just use the start event here
  server.on 'start', ->
    resolve(server)

internals.expectError = (payload, error, message, data = undefined) ->
  expect(payload).to.exist
  expect(payload.statusCode).to.be.a('number')
  expect(payload.error).to.be.a('string')
  expect(payload.message).to.be.a('string')
  expect(payload.error).to.equal(error)
  expect(payload.message).to.equal(message)
  if data
    expect(payload.data).to.be.a('string')
    expect(payload.data).to.equal(data)

module.exports =
  serverPromise: internals.serverPromise
  expectError: internals.expectError