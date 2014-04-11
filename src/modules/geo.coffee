mw = require("../middlewares")
_ = require("underscore")
request = require("request")

apiUrl = "https://freegeoip.net/json/"

module.exports.routes = [
  path: "%geo *"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    host = res.splats[0]

    request apiUrl + host, (err, response, body) ->
      if not err
        data = JSON.parse(body)
        if data? and response.statusCode is 200
          res.send "[geo] #{res.nick}, #{host} resolves to #{data.ip} (#{_.rest(_.values(data)).join(", ")})"
        else
          res.send "[geo] #{res.nick}, Look's like we're having problems with our api provider"
      else
        res.send "[geo] #{res.nick}, I've failed to lookup #{host}"
]
