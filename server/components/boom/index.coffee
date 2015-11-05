Boom = require('boom')

oldCreate = Boom.create
Boom.create = ->
  oldRet = oldCreate.apply(this, arguments)
  if oldRet.data? then oldRet.output.payload.details = oldRet.data
  return oldRet

module.exports = Boom