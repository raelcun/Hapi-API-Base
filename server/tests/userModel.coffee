process.env.NODE_ENV = 'test'

config = require('../config/env')
expect = require('chai').expect
Lab = require('lab')
mongoose = require('mongoose')
util = require('../components/util')

# make unit tests look like BDD
lab = exports.lab = Lab.script()
describe = lab.describe
it = lab.it
before = lab.before
after = lab.after
beforeEach = lab.beforeEach

internals = {}
internals.User = {}
internals.connection = {}

describe 'Login', ->

  before (done) ->
    internals.User = require('../models/user')
    done()

  it 'createNewUser with null scope', (done) ->
    internals.User.createNewUser('user', 'password').then (userModel) ->
      expect(userModel.scope).to.equal('user')
      done()

  it 'createNewUser bcrypt hash fails', (done) ->
    internals.User.createNewUser('user', { 'password': 'myPassword' })
      .then(
        null
        (err) ->
          expect(err.name).to.equal('Error')
          expect(err.message).to.equal('data must be a string and salt must either be a salt string or a number of rounds')
          done()
      )

  it 'validatePassword bcrypt compare fails', (done) ->
    internals.User.validatePassword({ 'password': 'password' }, 'mypasswordhash')
      .then(
        null
        (err) ->
          expect(err.name).to.equal('Error')
          expect(err.message).to.equal('data and hash must be strings')
          done()
      )