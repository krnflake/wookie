mw = require("../middlewares")

module.exports.routes = [
  path: "%home"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    res.send "[home] #{res.nick}, my home is: https://github.com/krnflake/wookie"
]
