domo = require("domo-kun")
fs = require("fs")
path = require("path")

modulesPath = path.join(__dirname, "/modules")
modules = []

users = []

config = JSON.parse(fs.readFileSync(path.join("__dirname", "../config.json"), 'utf8'))
config.users.forEach (user) ->
  users.push user

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
    users: users
    debug: if process.env.NODE_ENV == "production" then false else true
  )

  bot.use bot.basicRoutes()

  bot.connect()

process.on "uncaughtException", (err) ->
  console.log "ERROR: %s", err.stack
