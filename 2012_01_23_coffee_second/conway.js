(function() {
  var neighbors;

  exports.equal = require("./mattUtil.js").equal;

  exports.evolve = function(liveCells) {
    var c, cell, countMap, liveMap, n, nextGen, x, _i, _j, _len, _len2, _ref;
    liveMap = {};
    countMap = {};
    for (_i = 0, _len = liveCells.length; _i < _len; _i++) {
      cell = liveCells[_i];
      liveMap[cell] = cell;
      _ref = neighbors(cell);
      for (_j = 0, _len2 = _ref.length; _j < _len2; _j++) {
        c = _ref[_j];
        countMap[c] = (countMap[c] || 0) + 1;
      }
    }
    return nextGen = ((function() {
      var _results;
      _results = [];
      for (x in countMap) {
        n = countMap[x];
        if (3 === n || (2 === n && liveMap[x])) _results.push(liveMap[x]);
      }
      return _results;
    })()).sort();
  };

  neighbors = function(cell) {
    var indices, res, x;
    indices = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];
    return res = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = indices.length; _i < _len; _i++) {
        x = indices[_i];
        _results.push([x[0] + cell[0], x[1] + cell[1]]);
      }
      return _results;
    })();
  };

}).call(this);
