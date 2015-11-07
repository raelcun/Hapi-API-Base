config = require('../config/env')
jwt = require('jsonwebtoken')

module.exports =
  login: (request) ->
    username = request.payload?.username
    password = request.payload?.password
    tokenPayload =
      username: username
      scope: if username is 'admin' then 'admin' else 'user'
      remoteAddress: request.info.remoteAddress
      host: request.info.host

    if (username is 'admin' and password is 'admin') or (username is 'user' and password is 'user')
      return jwt.sign(tokenPayload, config.API.JWTSecret, { expiresIn: config.API.defaultTokenExp })
    else
      return null