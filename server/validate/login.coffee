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

module.exports =
  login:
    response: schema: loginResponse
    validate: payload: loginRequest