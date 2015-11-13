mongoose = require('mongoose')
bcrypt = require('bcrypt')
Promise = require('bluebird')
util = require('../components/util')
boom = require('boom')

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

UserSchema.statics.validateLogin = (username, plainPassword) ->
  this
    .find({ username: username })
    .then (docs) ->
      if docs.length isnt 1 then return null
      return new Promise (resolve, reject) ->
        bcrypt.compare plainPassword, docs[0].passwordHash, (err, res) ->
          if err then reject(err)
          if res then resolve(docs[0].toJSON()) else resolve(null)


UserSchema.statics.saveNewUser = (username, plainPassword, scope) ->
  self = this
  self
    .find({ username: username })
    .then (docs) ->
      if docs.length > 0 then throw boom.badRequest('Username already exists')
      return new Promise (resolve, reject) ->
        bcrypt.hash plainPassword, 10, (err, hash) ->
          if err then reject(err)
          newUser = new self()
          newUser.username = username
          newUser.scope = scope
          newUser.passwordHash = hash
          resolve(newUser)
    .then (newUser) ->
      newUser.save().then -> return newUser

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