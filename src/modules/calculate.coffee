mw = require("../middlewares")

module.exports.routes = [
  path: "%c *"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    # strip anything other than digits, (), -+/* and .
    queue = res.splats[0].replace(/[^-()\d/*+.]/g, '')

    try result = eval(queue)
    catch e
      res.send "[c] Unexpected token"
      return

    res.send "[c] #{res.nick}, #{result}"
]
