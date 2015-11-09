mongoose = require('mongoose')
bcrypt = require('bcrypt')
Promise = require('bluebird')
util = require('../components/util')

UserSchema = new mongoose.Schema
  scope:
    type: String
    required: true
  username:
    type: String
    required: true
  passwordHash:
    type: String
    required: true

UserSchema.statics.createNewUser = (username, plainPassword, scope = 'user') ->
  newUser = new this()
  return new Promise (resolve, reject) ->
    bcrypt.genSalt 10, (err, salt) ->
      bcrypt.hash plainPassword, salt, (err, hash) ->
        if err then reject(err)
        newUser.username = username
        newUser.scope = scope
        newUser.passwordHash = hash
        resolve(newUser)

UserSchema.statics.validatePassword = (plainPassword, hashedPassword) ->
  return new Promise (resolve, reject) ->
    bcrypt.compare plainPassword, hashedPassword, (err, res) ->
      if err then reject(err)
      resolve(res)

UserSchema
  .path 'username'
  .validate ((value) ->
    return not util.nullOrEmpty(value)
  )

UserSchema
  .path 'scope'
  .validate ((value) ->
    return not util.nullOrEmpty(value)
  ), 'scope cannot be blank'

UserSchema
  .path 'passwordHash'
  .validate ((value) ->
    return not util.nullOrEmpty(value)
  ), 'Hashed password cannot be blank'

module.exports = mongoose.model 'User', UserSchema