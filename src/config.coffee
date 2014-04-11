fs = require("fs")
path = require("path")

users = []

config = JSON.parse(fs.readFileSync(path.join("__dirname", "../config.json"), 'utf8'))
config.users.forEach (user) ->
  users.push user

exports.config = config
exports.users = users
