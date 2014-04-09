crypto = require("crypto")

timeout = 3
hashList = {}

exports.floodProtection = (res, next) ->
  stamp = new Date().getTime()
  key = hashKey res

  unless hashList[key]
    hashList[key] = stamp
    next()

  if (stamp - hashList[key]) <= timeout * 1000
    return
  else
    hashList[key] = stamp

  setTimeout (->
    delete hashList[key]
  ), (timeout * 1000)

  next()

hashKey = (res) ->
  new crypto.Hash("md5").update(res.prefix).digest "hex"
