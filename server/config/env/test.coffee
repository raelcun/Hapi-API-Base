module.exports =
  env: 'test'

  goodOptions:
    responsePayload: false
    reporters: [
        reporter: require('good-console')
        events:
          request: 'error'
          log: '*'
          response: 'error'
          error: '*'
    ]

  mongo:
    connection:
      database: 'inspire-me-test'
    logDB:
      database: 'inspire-me-test'