process.env.NODE_ENV = 'test'

config = require('../config/env')
expect = require('chai').expect
Lab = require('lab')
common = require('./common')
boom = require('boom')
util = require('../components/util')

# make unit tests look like BDD
lab = exports.lab = Lab.script()
describe = lab.describe
it = lab.it
before = lab.before
after = lab.after
beforeEach = lab.beforeEach

internals = {}
internals.server = {}

describe 'Misc', ->

  before (done) ->
    common.serverPromise.then (res) ->
      internals.server = res
      done()

  it 'boom data returned', (done) ->
    internals.server.route
      method: 'GET'
      path: '/testError'
      handler: (request, reply) -> return reply(boom.badRequest('Test Message', 'Test Data'))
      config:
        auth: false

    options = { method: 'GET', url: '/testError' }
    internals.server.inject options, (res) ->
      payload = JSON.parse(res.payload)
      common.expectError(payload, 'Bad Request', 'Test Message', 'Test Data')
      done()

  it 'constructMongoURI', (done) ->
    username = 'username'
    password = 'password'
    hostname = 'hostname'
    port = 80
    database = 'db'
    expect(util.constructMongoURI(username, password, hostname, port, database)).to.equal('mongodb://username:password@hostname:80/db')
    done()