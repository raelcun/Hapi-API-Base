config = require('../config/env')
jwt = require('jsonwebtoken')
User = require('../models/user')

module.exports =
  login: (username, password, remoteAddress, host) ->
    tokenPayload =
      username: username
      scope: if username is 'admin' then 'admin' else 'user'
      remoteAddress: remoteAddress
      host: host

    # User
    #   .find({ username: username }).exec()
    #   .then (results) ->
    #     console.log results

    if (username is 'admin' and password is 'admin') or (username is 'user' and password is 'user')
      return jwt.sign(tokenPayload, config.API.JWTSecret, { expiresIn: config.API.defaultTokenExp, algorithm: 'HS512' })
    else
      return null