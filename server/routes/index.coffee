fs = require('fs')
path = require('path')

module.exports = (server) ->
  fs.readdir __dirname, (err, files) ->
    files.forEach (e) ->
      ext = path.extname(e).toLowerCase()
      basename = path.basename(e, ext).toLowerCase()
      if ext isnt '.coffee' then return
      if basename is 'index' then return
      server.route(route) for route in require('./' + basename)