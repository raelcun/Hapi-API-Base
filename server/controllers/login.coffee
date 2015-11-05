config = require('../config/env')
jwt = require('jsonwebtoken')
boom = require('../components/boom')

module.exports =
  login: (request, reply) ->
    username = request.payload?.username
    password = request.payload?.password
    tokenPayload =
      username: username
      scope: if username is 'admin' then 'admin' else 'user'
      remoteAddress: request.info.remoteAddress
      host: request.info.host

    if (username is 'admin' and password is 'admin') or (username is 'dan' and password is 'dan')
      return reply({ token: jwt.sign(tokenPayload, config.API.JWTSecret, { expiresIn: config.APIOptions.defaultTokenExp }) })
    else
      return reply(boom.unauthorized('Invalid username or password'))