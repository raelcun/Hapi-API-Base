require('source-map-support').install()

hapi = require('hapi')
config = require('./config/env')
logger = require('./components/logger')
util = require('./components/util')
boom = require('boom')
jwt = require('jsonwebtoken')

# echo admin token for testing purposes
logger.debug(jwt.sign({ username: 'admin', scope: 'user' }, config.API.JWTSecret, { algorithm: 'HS512' }))

server = new hapi.Server()
server.connection(config.server)

###
# Make sure data in Boom messages is displayed
###
server.ext 'onPreResponse', (request, reply) ->
  if request.response?.isBoom and request.response?.data then request.response.output.payload.data = request.response.data
  return reply.continue()

###
# If authorization passed, validate host and remote ip
# unless token is for admin user
###
server.ext 'onPreAuth', (request, reply) ->
  if config.env is 'development' then return reply.continue() # ignore ip check for development purposes

  authorization = request.raw.req.headers.authorization
  parts = authorization?.split(/\s+/)
  if parts? and parts.length is 2 and parts[0].toLowerCase() is 'bearer'
    tokenPayload = jwt.decode(parts[1])
    if tokenPayload?.scope isnt 'admin' and (tokenPayload?.remoteAddress isnt request.info.remoteAddress or tokenPayload?.host isnt request.info.host)
      return reply(boom.unauthorized('Invalid token'))
  reply.continue()

server.register [
  { register: require('hapi-auth-jwt2') }
  { register: require('good'), options: config.goodOptions }
  # {
  #   register: require('hapi-mongodb')
  #   options:
  #     url: util.constructMongoURI.apply(config.mongo.connection)
  #     settings: config.mongo.settings.server
  # }
], (err) ->
  if err then logger.error 'Error loading plugins', err, -> process.exit(0)

  # setup authorization strategy
  server.auth.strategy 'jwt', 'jwt', true, {
    key: config.API.JWTSecret
    verifyOptions:
      algorithms: ['HS512']
    validateFunc: (decoded, request, cb) ->
      if decoded.username in ['dan', 'admin']
        return cb(null, true, decoded)
      else
        return cb(null, false, {})
  }
  server.auth.scope = ['admin', 'user']

  # require all routes
  require('./routes')(server)

  server.start ->
    logger.info "web interface started at https://#{config.server.host}:#{config.server.port} in #{config.env} mode"