Joi = require('joi')
boomSchema = require('./common/boom')

newUserRequest =
  username: Joi.string().required()
  password: Joi.string().required()

newUserResponse = Joi.alternatives().try(
  boomSchema,
  result: Joi.boolean()
).required()

module.exports =
  user:
    validate: payload: newUserRequest
    response: schema: newUserResponse