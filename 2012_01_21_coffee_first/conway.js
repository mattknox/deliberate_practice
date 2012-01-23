(function() {
  var evolve, mattUtil, neighbors, util;

  util = require("util");

  mattUtil = require("./mattUtil.js");

  evolve = function(liveCells) {
    var cell, count, liveMap, neighborCell, neighborCounts, nextGen, _i, _j, _len, _len2, _ref;
    liveMap = {};
    neighborCounts = {};
    for (_i = 0, _len = liveCells.length; _i < _len; _i++) {
      cell = liveCells[_i];
      liveMap[cell] = cell;
      _ref = neighbors(cell);
      for (_j = 0, _len2 = _ref.length; _j < _len2; _j++) {
        neighborCell = _ref[_j];
        neighborCounts[neighborCell] = (neighborCounts[neighborCell] || 0) + 1;
      }
    }
    return nextGen = ((function() {
      var _results;
      _results = [];
      for (cell in neighborCounts) {
        count = neighborCounts[cell];
        if (count === 3 || (count === 2 && liveMap[cell])) {
          _results.push(liveMap[cell]);
        }
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
        _results.push([x[0] + Number(cell[0]), x[1] + Number(cell[1])]);
      }
      return _results;
    })();
  };

  exports.equal = mattUtil.equal;

  exports.evolve = evolve;

}).call(this);
