mw = require("../middlewares")
config = require("../config")
client = require("node-wolfram")
wolfram = new client(config.config.wolfram)

module.exports.routes = [
  path: "%wa *"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    queue = res.splats[0]

    wolfram.query queue, (err, result) ->
      if not err and result.queryresult.pod[1].subpod[0].plaintext
        res.send "[wa] #{res.nick}, #{result.queryresult.pod[1].subpod[0].plaintext[0].split("\n").join(", ")}"
      else
        res.send "[wa] #{res.nick}, I've failed to look that up"
]
