mw = require("../middlewares")

module.exports.routes = [
  path: "%home"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    res.send "[home] https://github.com/krnflake/wookie"
]
