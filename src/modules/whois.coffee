mw = require("../middlewares")
helpers = require("../helpers")
exec = require('child_process').exec
path = require('path')
pastee = require("../pastee")

script = path.join(__dirname, "../vendor/python-whois/pwhois")

module.exports.routes = [
  path: "%whois *"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    host = helpers.escapeshell res.splats[0]

    exec "#{script} #{host}", (error, stdout, stderr) ->
      if not stderr and not error
        pastee.paste stdout + stderr, (data) ->
          if data?
            res.send "[whois] #{res.nick}, #{data.paste.link}"
          else
            res.send "[whois] #{res.nick}, Look's like we're having problems with our api provider"
      else
        res.send "[whois] #{res.nick}, I've failed to lookup #{host}"
]
