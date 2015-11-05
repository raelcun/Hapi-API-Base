winston = require 'winston'
require('winston-mongodb').MongoDB
config = require '../../config/env'
util = require '../util'

logLevel = if config.env is 'production' then 'info' else 'debug'

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
    level: 'info'
  }
)

winston.level = logLevel

module.exports = winston