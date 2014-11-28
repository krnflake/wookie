request = require("request")
config = require("../config")

apiUrl = "https://duckduckgo-duckduckgo-zero-click-info.p.mashape.com/?no_html=1&no_redirect=1&skip_disambig=1&format=json&q="

module.exports.routes = [
  path: "%ddg *"
  handler: (res) ->
    queue = res.splats[0]

    request
      url: apiUrl + queue
      headers:
        "X-Mashape-Authorization": config.config.mashape
    , (err, response, body) ->
      if not err
        data = JSON.parse(body)
        if data? and response.statusCode is 200 and data.AbstractText.length
          res.send "[ddg] #{res.nick}, #{data.AbstractText}"
        else
          res.send "[ddg] #{res.nick}, I have no idea :("
      else
        res.send "[ddg] #{res.nick}, Look's like we're having problems with our api provider"
]
