mw = require("../middlewares")
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
        if data?
          res.send "[geo] #{data.ip} -> #{data.country_name} / #{data.region_name} / #{data.city} (#{data.zipcode})"
        else
          res.send "[geo] Look's like we're having problems with our api provider"
      else
        res.send "[geo] I've failed to lookup #{host}"
]
