LoginCtrl = require('../controllers/login')
LoginValidation = require('../validate/login')

module.exports = [
  {
    method: 'POST'
    path: '/login'
    handler: LoginCtrl.login
    config:
      auth: false
      response: LoginValidation.login.response
      validate: LoginValidation.login.validate
  }
]