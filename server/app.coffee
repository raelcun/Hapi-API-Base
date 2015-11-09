require('source-map-support').install()

hapi = require('hapi')
config = require('./config/env')
logger = require('./components/logger')
util = require('./components/util')
boom = require('boom')
jwt = require('jsonwebtoken')
Promise = require('bluebird')
mongoose = require('mongoose')

# echo admin token for testing purposes
logger.debug('admin token:', jwt.sign({ username: 'admin', scope: 'admin' }, config.API.JWTSecret, { algorithm: 'HS512' }))
logger.debug('user token:', jwt.sign({ username: 'user', scope: 'user' }, config.API.JWTSecret, { algorithm: 'HS512' }))

server = new hapi.Server()
server.connection(config.server)

###
# Make sure data in Boom messages is displayed
###
server.ext 'onPreResponse', (request, reply) ->
  if request.response.isBoom and request.response.data then request.response.output.payload.data = request.response.data
  return reply.continue()

###
# If authorization passed, validate host and remote ip
# unless token is for admin user
###
server.ext 'onPreAuth', (request, reply) ->
  authorization = request.raw.req.headers.authorization
  parts = authorization?.split(/\s+/)
  if parts? and parts.length is 2 and parts[0].toLowerCase() is 'bearer'
    tokenPayload = jwt.decode(parts[1])
    if tokenPayload? and tokenPayload.scope isnt 'admin' and (tokenPayload.remoteAddress isnt request.info.remoteAddress or tokenPayload.host isnt request.info.host)
      return reply(boom.unauthorized('Invalid token')) # ignore ip check unless in production
  reply.continue()

# gracefully disconnect from db when server is killed
gracefulDBExit = ->
  mongoose.connection.close ->
    logger.warn 'Mongoose connection terminated due to app termination', {}, -> process.exit(0)
process.on('SIGINT', gracefulDBExit).on('SIGTERM', gracefulDBExit)

mongoose.connection.on 'disconnected', -> logger.info 'Mongoose default connection disconnected'

mongoose.connection.on 'connected', ->
  server.register [
    { register: require('hapi-auth-jwt2') }
    { register: require('good'), options: config.goodOptions }
  ], (err) ->
    # setup authorization strategy
    server.auth.strategy 'jwt', 'jwt', true, {
      key: config.API.JWTSecret
      verifyOptions:
        algorithms: ['HS512']
      validateFunc: (decoded, request, cb) ->
        if decoded.username in ['user', 'admin']
          return cb(null, true, decoded)
        else
          return cb(null, false, {})
    }
    server.auth.scope = ['admin', 'user']

    # require all routes
    require('./routes')(server)

    server.start ->
      logger.info "web interface started at https://#{config.server.host}:#{config.server.port} in #{config.env} mode"

mongoose.connect(
  util.constructMongoURI(
    config.mongo.connection.username
    config.mongo.connection.password
    config.mongo.connection.hostname
    config.mongo.connection.port
    config.mongo.connection.database
  ),
  config.mongo.settings
)

module.exports = server