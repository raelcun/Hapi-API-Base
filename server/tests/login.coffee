process.env.NODE_ENV = 'test'

config = require('../config/env')
expect = require('chai').expect
Lab = require('lab')
common = require('./common')
jwt = require('jsonwebtoken')
Promise = require('bluebird')

# make unit tests look like BDD
lab = exports.lab = Lab.script()
describe = lab.describe
it = lab.it
before = lab.before
after = lab.after
beforeEach = lab.beforeEach

internals = {}
internals.server = {}
internals.userModel = {}
internals.users = [
  { username: 'admin', password: 'admin', scope: 'admin' }
  { username: 'user', password: 'user', scope: 'user' }
]
internals.userModels = []

describe 'Login', ->

  before (done) ->
    common.serverPromise.then (res) ->
      internals.server = res
      internals.User = require('../models/user')

      # remember that the promises used here are mongoose promises, not bluebird promises
      # so, for example, there isn't a catch function
      internals.User.remove({}).exec() # remove all users
        .then -> # create all users
          Promise.map internals.users, (e) -> internals.User.createNewUser(e.username, e.password, e.scope)
        .then (models) ->
          internals.userModels = models # save user models
          Promise.map models, (e) -> e.save() # save models to db
        .then -> done()

  it 'login success', (done) ->
    user = internals.users[1]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password } }
    internals.server.inject options, (res) ->
      payload = JSON.parse(res.payload)
      expect(payload.result).to.be.a('string')
      done()

  it 'invalid username', (done) ->
    user = internals.users[1]
    options = { method: 'POST', url: '/login', payload: { username: user.username + 'a', password: user.password } }
    internals.server.inject options, (res) ->
      payload = JSON.parse(res.payload)
      common.expectError(payload, 'Unauthorized', 'Invalid username or password')
      done()

  it 'invalid user password', (done) ->
    user = internals.users[1]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password + 'a' } }
    internals.server.inject options, (res) ->
      payload = JSON.parse(res.payload)
      common.expectError(payload, 'Unauthorized', 'Invalid username or password')
      done()

  it 'invalid admin password', (done) ->
    user = internals.users[0]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password + 'a' } }
    internals.server.inject options, (res) ->
      payload = JSON.parse(res.payload)
      common.expectError(payload, 'Unauthorized', 'Invalid username or password')
      done()

  it 'valid user authorization', (done) ->
    user = internals.users[1]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password } }
    internals.server.inject options, (res) ->
      token = JSON.parse(res.payload).result
      options = { method: 'GET', url: '/user', headers: authorization: 'Bearer ' + token }
      internals.server.inject options, (res) ->
        payload = JSON.parse(res.payload)
        expect(payload.result).to.equal('user only')
        done()

  it 'valid admin authorization', (done) ->
    user = internals.users[0]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password } }
    internals.server.inject options, (res) ->
      token = JSON.parse(res.payload).result
      options = { method: 'GET', url: '/admin', headers: authorization: 'Bearer ' + token }
      internals.server.inject options, (res) ->
        payload = JSON.parse(res.payload)
        expect(payload.result).to.equal('admin only')
        done()

  it 'insufficient admin scope', (done) ->
    user = internals.users[0]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password } }
    internals.server.inject options, (res) ->
      token = JSON.parse(res.payload).result
      options = { method: 'GET', url: '/user', headers: authorization: 'Bearer ' + token }
      internals.server.inject options, (res) ->
        payload = JSON.parse(res.payload)
        common.expectError(payload, 'Forbidden', 'Insufficient scope, expected any of: user')
        done()

  it 'signed token with invalid login credentials', (done) ->
    tokenPayload =
      username: 'fakeUsername'
      scope: 'admin'
    fakeToken = jwt.sign(tokenPayload, config.API.JWTSecret, { expiresIn: config.API.defaultTokenExp, algorithm: 'HS512' })

    options = { method: 'GET', url: '/admin', headers: authorization: 'Bearer ' + fakeToken }
    internals.server.inject options, (res) ->
      payload = JSON.parse(res.payload)
      common.expectError(payload, 'Unauthorized', 'Invalid credentials')
      done()

  it 'non-matching remote address for non-admin user', (done) ->
    user = internals.users[1]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password } }
    internals.server.inject options, (res) ->
      tokenPayload = JSON.parse(res.payload).result
      decoded = jwt.decode(tokenPayload)
      decoded.remoteAddress = '216.68.10.113'
      token = jwt.sign(decoded, config.API.JWTSecret, { expiresIn: config.API.defaultTokenExp, algorithm: 'HS512' })

      options = { method: 'GET', url: '/user', headers: authorization: 'Bearer ' + token }
      internals.server.inject options, (res) ->
        payload = JSON.parse(res.payload)
        common.expectError(payload, 'Unauthorized', 'Invalid token')
        done()

  it 'non-matching host for non-admin user', (done) ->
    user = internals.users[1]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password } }
    internals.server.inject options, (res) ->
      tokenPayload = JSON.parse(res.payload).result
      decoded = jwt.decode(tokenPayload)
      decoded.host = 'localhost:80' # change port
      token = jwt.sign(decoded, config.API.JWTSecret, { expiresIn: config.API.defaultTokenExp, algorithm: 'HS512' })

      options = { method: 'GET', url: '/user', headers: authorization: 'Bearer ' + token }
      internals.server.inject options, (res) ->
        payload = JSON.parse(res.payload)
        common.expectError(payload, 'Unauthorized', 'Invalid token')
        done()

  it 'invalid token format', (done) ->
    options = { method: 'GET', url: '/user', headers: authorization: 'Bearer joikfdsajlkfasd' }
    internals.server.inject options, (res) ->
      payload = JSON.parse(res.payload)
      common.expectError(payload, 'Unauthorized', 'Invalid token format')
      done()

  it 'authorization header, but spaces in token', (done) ->
    # could break parts variable in preauth code
    options = { method: 'GET', url: '/user', headers: authorization: 'Bearer a a' }
    internals.server.inject options, (res) ->
      payload = JSON.parse(res.payload)
      common.expectError(payload, 'Unauthorized', 'Invalid token format')
      done()

  it 'noAuth endpoint', (done) ->
    options = { method: 'GET', url: '/' }
    internals.server.inject options, (res) ->
      payload = JSON.parse(res.payload)
      expect(payload.result).to.equal('no auth')
      done()

  it 'useradmin endpoint as user', (done) ->
    user = internals.users[1]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password } }
    internals.server.inject options, (res) ->
      token = JSON.parse(res.payload).result
      options = { method: 'GET', url: '/useradmin', headers: authorization: 'Bearer ' + token }
      internals.server.inject options, (res) ->
        payload = JSON.parse(res.payload)
        expect(payload.result).to.equal('user or admin')
        done()

  it 'useradmin endpoint as admin', (done) ->
    user = internals.users[0]
    options = { method: 'POST', url: '/login', payload: { username: user.username, password: user.password } }
    internals.server.inject options, (res) ->
      token = JSON.parse(res.payload).result
      options = { method: 'GET', url: '/useradmin', headers: authorization: 'Bearer ' + token }
      internals.server.inject options, (res) ->
        payload = JSON.parse(res.payload)
        expect(payload.result).to.equal('user or admin')
        done()