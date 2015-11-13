process.env.NODE_ENV = 'test'

config = require('../config/env')
expect = require('chai').expect
Lab = require('lab')
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