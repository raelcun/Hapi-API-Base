boom = require('boom')
loginDAO = require('../dao/login')

module.exports =
  login: (request, reply) ->
    loginDAO
      .login(request.payload.username, request.payload.password, request.info.remoteAddress, request.info.host)
      .then (token) ->
        if token?
          return reply({ result: token })
        else
          return reply(boom.unauthorized('Invalid username or password'))