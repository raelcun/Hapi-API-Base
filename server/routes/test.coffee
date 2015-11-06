TestCtrl = require('../controllers/test')

module.exports = [
  {
    method: 'GET'
    path: '/user'
    handler: TestCtrl.userOnly
    config:
      auth:
        strategy: 'jwt'
        scope: 'user'
  }
  {
    method: 'GET'
    path: '/admin'
    handler: TestCtrl.adminOnly
    config:
      auth:
        strategy: 'jwt'
        scope: 'admin'
  }
  {
    method: 'GET'
    path: '/useradmin'
    handler: TestCtrl.userOrAdmin
    config:
      auth:
        strategy: 'jwt'
        scope: ['user', 'admin']
  }
  {
    method: 'GET'
    path: '/'
    handler: TestCtrl.noAuth
    config:
      auth: false
  }
]