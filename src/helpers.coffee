# http://stackoverflow.com/a/7685469
exports.escapeshell = (cmd) ->
  "\"" + cmd.replace(/(["\s'$`\\])/g, "\\$1") + "\""
