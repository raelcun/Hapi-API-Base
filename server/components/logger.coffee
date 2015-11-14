config = require('../config/env')
winston = require('winston')
require('winston-mongodb').MongoDB
util = require('./util')

logLevel = 'debug'
# turn code coverage off since all testing is done with a test environment, so these lines will never be hit during a test
### $lab:coverage:off$ ###
if config.env is 'production' then logLevel = 'info'
if config.env is 'development' then logLevel = 'debug'
if config.env is 'test' then logLevel = 'error'
### $lab:coverage:on$ ###

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

winston.level = logLevel

module.exports = winston