mattUtil = require("./mattUtil.js") # needed for the equal function

evolve = (liveCells) ->
  liveMap = {}
  neighborCounts = {}
  for cell in liveCells
    liveMap[cell] = cell
    for neighborCell in neighbors(cell)
      neighborCounts[neighborCell] = (neighborCounts[neighborCell] || 0) + 1
  nextGen = (liveMap[cell] for cell, count of neighborCounts when (count is 3 || (count is 2 and liveMap[cell]))).sort()


neighbors = (cell) ->
  indices = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  res = ([x[0] + Number(cell[0]), x[1] + Number(cell[1])] for x in indices)

exports.equal = mattUtil.equal
exports.evolve = evolve
