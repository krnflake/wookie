domo = require("domo-kun")
fs = require("fs")
path = require("path")
config = require("./config")

modulesPath = path.join(__dirname, "/modules")
modules = []

fs.readdir modulesPath, (err, files) ->
  files.forEach (file) ->
    modules.push path.join(modulesPath, file)

  bot = new domo(
    nick: "wookie_"
    userName: "wookie_"
    realName: "Yet another IRC bot."
    address: "irc.freenode.org"
    modules: modules
    channels: ["#domo-kun"]
    users: config.users
    debug: if process.env.NODE_ENV == "production" then false else true
  )

  bot.use bot.basicRoutes()

  bot.connect()

process.on "uncaughtException", (err) ->
  console.log "ERROR: %s", err.stack
