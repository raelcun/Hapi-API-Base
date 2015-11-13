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

  deleteUser: (request, reply) ->
    UserModel
      .deleteUser(request.payload.username)
      .then(
        (result) ->
          reply({ result: result })
        (err) ->
          reply(boom.wrap(err))
      )