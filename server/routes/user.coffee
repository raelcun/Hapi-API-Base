UserCtrl = require('../controllers/user')
UserValidation = require('../validate/user')

module.exports = [
  {
    method: 'POST'
    path: '/user/create'
    handler: UserCtrl.createNewUser
    config:
      auth:
        strategy: 'jwt'
        scope: 'admin'
      response: UserValidation.user.response
      validate: UserValidation.user.validate
  }
]