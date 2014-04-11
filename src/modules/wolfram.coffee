mw = require("../middlewares")
config = require("../config")
wolfram = require('wolfram').createClient(config.config.wolfram)

module.exports.routes = [
  path: "%wa *"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    queue = res.splats[0]

    wolfram.query queue, (err, result) ->
      if not err and result[1].subpods[0].value
        res.send "[wa] #{res.nick}, #{result[1].subpods[0].value}"
      else
        res.send "[wa] #{res.nick}, I've failed to look that up"
]
