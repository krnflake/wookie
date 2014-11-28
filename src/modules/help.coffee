module.exports.routes = [
  path: "%help"
  handler: (res) ->
    modules = []
    Object.keys(res.client.routes).forEach (module) ->
      modules.push module  if module.charAt(0) is "%"
    res.send "[help] #{res.nick}, I know these commands: #{modules.join(", ")}"
]
