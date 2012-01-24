exports.equal = require("./mattUtil.js").equal
exports.evolve = (liveCells) ->
  liveMap = {}
  countMap = {}
  for cell in liveCells
    liveMap[cell] = cell
    for c in neighbors(cell)
      countMap[c] = (countMap[c] || 0) + 1
  (liveMap[x] for x, n of countMap when (3 is n || (2 is n and liveMap[x]))).sort()

neighbors = (cell) ->
  indices = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  res = ([x[0] + cell[0], x[1] + cell[1]] for x in indices)
