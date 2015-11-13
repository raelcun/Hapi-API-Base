Joi = require('joi')
boomSchema = require('./common/boom')

newUserRequest =
  username: Joi.string().required()
  password: Joi.string().required()

newUserResponse = Joi.alternatives().try(
  boomSchema,
  result: Joi.boolean()
).required()

deleteRequest =
  username: Joi.string().required()

deleteResponse = Joi.alternatives().try(
  boomSchema,
  result: Joi.boolean()
).required()

module.exports =
  create:
    validate: payload: newUserRequest
    response: schema: newUserResponse
  delete:
    validate: payload: deleteRequest
    response: schema: deleteResponse