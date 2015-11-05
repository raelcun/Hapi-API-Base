module.exports =
  env: 'development'

  mongo:
    connection:
      username: 'node'
      password: 'node'
      hostname: '192.168.33.10'
      port: 27017
      database: 'inspire-me'
    settings:
      server:
        socketOptions:
          keepAlive: 1
          connectTimeoutMS: 30000
    logDB:
      username: 'node'
      password: 'node'
      hostname: '192.168.33.10'
      port: 27017
      database: 'inspire-me'
      collection: 'logs'