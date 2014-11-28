module.exports.routes = [
  path: "%home"
  handler: (res) ->
    res.send "[home] #{res.nick}, my home is: https://github.com/krnflake/wookie"
]
