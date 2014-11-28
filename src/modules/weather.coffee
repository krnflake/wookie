request = require("request")

apiUrl = "http://api.openweathermap.org/data/2.5/weather?q="

module.exports.routes = [
  path: "%weather *"
  handler: (res) ->
    loc = res.splats[0]

    request apiUrl + loc, (err, response, body) ->
      if not err
        data = JSON.parse(body)
        if data? and data.cod is 200
          res.send "[weather] #{res.nick}, Weather for #{data.name}: #{data.weather[0].main} -> temp: #{Math.round(parseFloat(data.main.temp) - 273.15)}C, pressure: #{data.main.pressure}Pa, humidity: #{data.main.humidity}% and windspeed: #{data.wind.speed}m/s"
        else
          res.send "[weather] #{res.nick}, Look's like we're having problems with our api provider"
      else
        res.send "[weather] #{res.nick}, I've failed to lookup #{loc}"
]
