boom = require('boom')
UserModel = require('../models/user')

module.exports =
  createNewUser: (request, reply) ->
    UserModel
      .saveNewUser(request.payload.username, request.payload.password, 'user')
      .then(
        (user) ->
          return reply({ result: true })
        (err) ->
          reply(boom.wrap(err))
      )