config = require('../config/env')
jwt = require('jsonwebtoken')
boom = require('boom')
LoginModel = require('../models/user')

module.exports =
  login: (request, reply) ->
    LoginModel
      .validateLogin(request.payload.username, request.payload.password)
      .then (doc) ->
        if doc is null then return reply(boom.unauthorized('Invalid username or password'))

        tokenPayload =
          username: doc.username
          scope: doc.scope
          remoteAddress: request.info.remoteAddress
          host: request.info.host
        token = jwt.sign(tokenPayload, config.API.JWTSecret, { expiresIn: config.API.defaultTokenExp, algorithm: 'HS512' })
        return reply({ result: token })