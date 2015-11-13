process.env.NODE_ENV = 'test'

config = require('../config/env')
expect = require('chai').expect
Lab = require('lab')
common = require('./common')
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
internals.User = {}
internals.users = [
  { username: 'admin', password: 'admin', scope: 'admin' }
  { username: 'user', password: 'user', scope: 'user' }
]

internals.login = (username, password) ->
  return new Promise (resolve, reject) ->
    options = { method: 'POST', url: '/login', payload: { username: username, password: password } }
    internals.server.inject options, (res) ->
      resolve(JSON.parse(res.payload).result)

describe 'User', ->

  before (done) ->
    common.serverPromise.then (res) ->
      internals.server = res
      internals.User = require('../models/user')
      done()

  beforeEach (done) ->
    # remember that the promises used here are mongoose promises, not bluebird promises
    # so, for example, there isn't a catch function
    internals.User.remove({}).exec() # remove all users
      .then -> # create all users
        Promise.map internals.users, (e) -> internals.User.saveNewUser(e.username, e.password, e.scope)
      .then (models) ->
        internals.userModels = models # save user models
      .then -> done()

  it 'new user success', (done) ->
    user = internals.users[0]
    internals.login(user.username, user.password)
      .then (token) ->
        newUser = { username: 'newUser', password: 'newPassword' }
        options = { method: 'POST', url: '/user/create', payload: newUser, headers: authorization: 'Bearer ' + token }
        internals.server.inject options, (res) ->
          payload = JSON.parse(res.payload)
          expect(payload.result).to.equal(true)
          done()

  it 'username already exists', (done) ->
    user = internals.users[0]
    internals.login(user.username, user.password)
      .then (token) ->
        newUser = { username: internals.users[1].username, password: internals.users[1].password }
        options = { method: 'POST', url: '/user/create', payload: newUser, headers: authorization: 'Bearer ' + token }
        internals.server.inject options, (res) ->
          payload = JSON.parse(res.payload)
          common.expectError(payload, 'Bad Request', 'Username already exists')
          done()

  it 'user model called incorrectly', (done) ->
    internals.User.saveNewUser('newUser', { 'password': 'password' }, 'user')
      .then(
        null
        (err) ->
          expect(err.message).to.equal('data must be a string and salt must either be a salt string or a number of rounds')
          done()
      )