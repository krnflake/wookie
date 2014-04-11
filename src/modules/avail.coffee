mw = require("../middlewares")
request = require("request")
config = require("../config")

apiUrl = "https://domainr-domainr.p.mashape.com/json/info?q="

module.exports.routes = [
  path: "%avail *"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    host = res.splats[0]

    request
      url: apiUrl + host
      headers:
        "X-Mashape-Authorization": config.config.mashape
    , (err, response, body) ->
      if not err
        data = JSON.parse(body)
        if data? and response.statusCode is 200
          res.send "[avail] #{res.nick}, #{host} is #{data.availability}"
        else
          res.send "[avail] #{res.nick}, Look's like we're having problems with our api provider"
      else
        res.send "[avail] #{res.nick}, I've failed to lookup #{host}"
]
