mongoose = require('mongoose')
bcrypt = require('bcrypt')
Promise = require('bluebird')
util = require('../components/util')

UserSchema = new mongoose.Schema
  userScope:
    type: String
    required: true
  username:
    type: String
    required: true
  passwordHash:
    type: String
    required: true

UserSchema.statics.createNewUser = (username, plainPassword, userScope = 'user') ->
  newUser = new this()
  return new Promise (resolve, reject) ->
    bcrypt.genSalt 10, (err, salt) ->
      if err then reject(err)
      bcrypt.hash plainPassword, salt, (err, hash) ->
        if err then reject(err)
        newUser.username = username
        newUser.userScope = userScope
        newUser.passwordHash = hash
        resolve(newUser)

UserSchema.statics.validatePassword = (plainPassword) ->
  return new Promise (resolve, reject) ->
    bcrypt.compare plainPassword, @passwordHash, (err, res) ->
      if err then reject(err)
      resolve(res)

UserSchema
  .path 'username'
  .validate ((value) ->
    return not util.nullOrEmpty(value)
  )

UserSchema
  .path 'userScope'
  .validate ((value) ->
    return not util.nullOrEmpty(value)
  ), 'userScope cannot be blank'

UserSchema
  .path 'passwordHash'
  .validate ((value) ->
    return not util.nullOrEmpty(value)
  ), 'Hashed password cannot be blank'

module.exports = mongoose.model 'User', UserSchema