request = require("request")

apiUrl = "http://paste.ee/api"

exports.paste = (data, cb) ->
  request.post apiUrl,
    form:
      key: "public"
      description: "description"
      paste: data
      format: "json"
    , (err, res, body) ->
      cb?(JSON.parse(body))
