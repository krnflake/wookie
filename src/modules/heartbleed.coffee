mw = require("../middlewares")
helpers = require("../helpers")
exec = require('child_process').exec
url = require("url")
path = require("path")

script = path.join(__dirname, "../../heartbleed/heartbleed_modified.py")

module.exports.routes = [
  path: "%heartbleed *"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    host = helpers.escapeshell(res.splats[0])

    exec "python #{script} #{host}", (error, stdout, stderr) ->
      if not stderr and not error
        if stdout.indexOf("not vulnerable") isnt -1
          res.send "[heartbleed] #{res.nick}, no heartbeat response received from #{host}, server likely not vulnerable"
        else
          res.send "[heartbleed] #{res.nick}, received a heartbeat response from #{host}, server likely is vulnerable!"
      else
        res.send "[heartbleed] #{res.nick}, I've failed to look that up (make sure you use this format: domain.tld)"
]
