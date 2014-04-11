mw = require("../middlewares")
helpers = require("../helpers")
exec = require('child_process').exec
pastee = require("../pastee")

module.exports.routes = [
  path: "%ping *"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    host = helpers.escapeshell res.splats[0]

    exec "ping #{host} -c 5", (error, stdout, stderr) ->
      if not stderr and not error
        pastee.paste stdout + stderr, (data) ->
          if data?
            res.send "[ping] #{res.nick}, #{data.paste.link}"
          else
            res.send "[ping] #{res.nick}, Look's like we're having problems with our api provider"
      else
        res.send "[ping] #{res.nick}, I've failed to lookup #{host}"
]
