Joi = require('joi')
boomSchema = require('./common/boom')
_ = require('lodash')

loginRequest =
  username: Joi.string().required()
  password: Joi.string().required()

loginResponse = Joi.alternatives().try(
  boomSchema,
  result: Joi.string()
).required()

refreshTokenRequest =
  token: Joi.string().required()

refreshTokenResponse = Joi.alternatives().try(
  boomSchema,
  result: Joi.string()
).required()

module.exports =
  login:
    validate: payload: loginRequest
    response: schema: loginResponse
  refreshToken:
    validate: payload: refreshTokenRequest
    response: schema: refreshTokenResponse