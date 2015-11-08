config = require('../config/env')
winston = require('winston')
require('winston-mongodb').MongoDB
util = require('./util')

# turn code coverage off since all testing is done with a test environment, so these lines will never be hit during a test
### $lab:coverage:off$ ###
logLevel = 'debug'
if config.env is 'production' then logLevel = 'info'
if config.env is 'development' then logLevel = 'debug'
if config.env is 'test' then logLevel = 'error'

if config.env isnt 'test'
  winston.add(
    winston.transports.MongoDB,
    {
      db: util.constructMongoURI(
        config.mongo.logDB.username
        config.mongo.logDB.password
        config.mongo.logDB.hostname
        config.mongo.logDB.port
        config.mongo.logDB.database
      )
      collection: config.mongo.logDB.collection
      level: logLevel
    }
  )
### $lab:coverage:on$ ###

winston.level = logLevel

module.exports = winston