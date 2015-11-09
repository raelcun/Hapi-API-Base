config = require('../config/env')
jwt = require('jsonwebtoken')
User = require('../models/user')

module.exports =
  login: (username, password, remoteAddress, host) ->
    User
      .find({ username: username }).exec()
      .then (docs) ->
        if docs.length isnt 1 then return null
        User
          .validatePassword(password, docs[0].passwordHash)
          .then (validated) ->
            if validated isnt true then return null

            tokenPayload =
              username: docs[0].username
              scope: docs[0].scope
              remoteAddress: remoteAddress
              host: host
            return jwt.sign(tokenPayload, config.API.JWTSecret, { expiresIn: config.API.defaultTokenExp, algorithm: 'HS512' })