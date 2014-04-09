mw = require("../middlewares")
whois = require("node-whois")
pastee = require("../pastee")

module.exports.routes = [
  path: "%whois *"
  middlewares: [mw.floodProtection]
  handler: (res) ->
    host = res.splats[0]

    whois.lookup host, (err, data) ->
      if not err
        pastee.paste data, (data) ->
          if data?
            res.send "[whois] #{data.paste.link}"
          else
            res.send "[whois] Look's like we're having problems with our api provider"
      else
        res.send "[whois] I've failed to lookup #{host}"
]
