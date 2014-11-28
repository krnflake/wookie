helpers = require("../helpers")
exec = require('child_process').exec
pastee = require("../pastee")

module.exports.routes = [
  path: "%trace *"
  handler: (res) ->
    host = helpers.escapeshell res.splats[0]

    exec "traceroute #{host}", (error, stdout, stderr) ->
      if not stderr and not error
        pastee.paste stdout + stderr, (data) ->
          if data?
            res.send "[trace] #{res.nick}, #{data.paste.link}"
          else
            res.send "[trace] #{res.nick}, Look's like we're having problems with our api provider"
      else
        res.send "[trace] #{res.nick}, I've failed to lookup #{host}"
]
