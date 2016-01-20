path = require('path')
_ = require('lodash')
fs = require('fs')
path = require('path')

# default environment to development if environment variable doesn't exist
#process.env.NODE_ENV or= 'development'

all =
  env: process.env.NODE_ENV

  API:
    JWTSecret: '3E5_^7Z%rH5$%c3jwpQ#uA#O0*k5ltB*zK#yrYFeIScChyHbtW6h&woQM8j49cVU'
    defaultTokenExp: 15 * 60 # in seconds

  server:
    host: 'localhost'
    port: 9000
    routes:
      cors: true
    tls:
      key: fs.readFileSync(path.join(__dirname, '../../ssl/key.pem'), 'utf8')
      cert: fs.readFileSync(path.join(__dirname, '../../ssl/cert.pem'), 'utf8')

  goodOptions:
    responsePayload: true
    reporters: [
        reporter: require('good-console')
        events:
          request: '*'
          log: '*'
          response: '*'
          error: '*'
    ]

  mongo:
    connection:
      username: 'node'
      password: 'node'
      hostname: '192.168.33.10'
      port: 27017
      database: 'hapi-api'
    settings:
      server:
        socketOptions:
          keepAlive: 1
          connectTimeoutMS: 30000
    logDB:
      username: 'node'
      password: 'node'
      hostname: '192.168.33.10'
      port: 27017
      database: 'hapi-api'
      collection: 'logs'

module.exports = _.merge({}, all, require("./#{process.env.NODE_ENV}.js"))