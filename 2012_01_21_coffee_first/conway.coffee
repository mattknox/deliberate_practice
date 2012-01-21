mattUtil = require("./mattUtil.js") # needed for the equal function

conway =
  evolve: (liveCells) -> liveCells
  equal: mattUtil.equal


exports.evolve = conway.evolve
exports.equal  = conway.equal
