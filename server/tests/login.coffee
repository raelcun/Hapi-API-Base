process.env.NODE_ENV = 'test'

config = require('../config/env')
expect = require('chai').expect
Lab = require('lab')
Promise = require('bluebird')
jwt = require('jsonwebtoken')
serverPromise = require('./common')

# make unit tests look like BDD
lab = exports.lab = Lab.script()
describe = lab.describe
it = lab.it
before = lab.before
after = lab.after
beforeEach = lab.beforeEach

internals = {}
internals.server = {}
internals.users = [
  { username: 'admin', password: 'admin' }
  { username: 'user', password: 'user' }
]

describe 'Login', ->

  before (done) ->
    serverPromise.then (res) ->
      internals.server = res
      done()

  it 'login success', (done) ->
    user = internals.users[1]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password } }
    internals.server.inject options, (res) ->
      payload = JSON.parse(res.payload)

      expect(payload.result).to.be.a('string')

      done()