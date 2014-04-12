crypto = require("crypto")

timeout = 3
hashList = {}

exports.floodProtection = (res, next) ->
  stamp = new Date().getTime()
  key = hashKey res

  unless hashList[key]
    hashList[key] = stamp
    return next()

  if (stamp - hashList[key]) <= timeout * 1000
    @say res.nick, "Don't flood me with querys!"
    return
  else
    hashList[key] = stamp

  setTimeout (->
    delete hashList[key]
  ), (timeout * 1000)

  return next()

hashKey = (res) ->
  new crypto.Hash("md5").update(res.prefix).digest "hex"
