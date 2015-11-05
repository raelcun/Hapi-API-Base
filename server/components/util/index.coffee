module.exports =
  constructMongoURI: (username, password, hostname, port, database) ->
    return "mongodb://#{username}:#{password}@#{hostname}:#{port}/#{database}"