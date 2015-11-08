boom = require('boom')

module.exports =
  userOnly: (request, reply) -> return reply({ result: 'user only' })
  adminOnly: (request, reply) -> return reply({ result: 'admin only' })
  userOrAdmin: (request, reply) -> return reply({ result: 'user or admin' })
  noAuth: (request, reply) -> return reply({ result: 'no auth' })