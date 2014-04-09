mw = require("../middlewares")

module.exports.routes = [
  path: "%dd"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    res.send "[dd] dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync; unlink test"
]
