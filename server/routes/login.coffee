LoginCtrl = require('../controllers/login')

module.exports = [
  {
    method: 'POST'
    path: '/login'
    handler: LoginCtrl.login
    config: auth: false
  }
]