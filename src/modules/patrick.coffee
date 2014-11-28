images = [
          "http://i.imgur.com/cpcbUkH.gif",
          "http://i.imgur.com/LExJFpP.gif",
          "http://i.imgur.com/CIUmb1i.gif",
          "http://i.imgur.com/SuolpqE.jpg",
          "http://i.imgur.com/1Wf2kcm.gif",
          "http://i.imgur.com/sD3szd8.gif"
          ]

module.exports.routes = [
  path: "%patrick"
  handler: (res) ->
    res.send "[patrick] #{images[Math.floor(Math.random() * images.length)]}"
]
