module.exports =
  constructMongoURI: (username, password, hostname, port, database) ->
    return "mongodb://#{username}:#{password}@#{hostname}:#{port}/#{database}"

  nullOrEmpty: (s) ->
    return not (s? and s.length > 0)