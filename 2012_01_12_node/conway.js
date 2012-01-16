var util = require("util");
var mattUtil = require("./matt_util.js");

exports.evolve = function(liveCells) {
  var nextGen = [];
  var liveMap = {};
  var neighborCounts = {};
  for(var i = 0; i < liveCells.length; i++) {
    liveMap[liveCells[i].join(",")] = 1;
    var neighborCells = this.neighbors(liveCells[i]);
    for (var j = 0; j < neighborCells.length; j++) {
      var index = neighborCells[j].join(",");
      neighborCounts[index] = (neighborCounts[index] || 0) + 1;
    }
  }

  for( k in neighborCounts){
    if( neighborCounts[k] == 3 || ((neighborCounts[k] == 2) && liveMap[k])) {
      nextGen.push(mattUtil.splitToNumbers(k));
    }
  }
  return nextGen.sort();
};

exports.neighbors = function(cell) {
  var indices = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];
  var arr = [];
  for (var i = 0; i < 8; i++){
    var c = [cell[0] + indices[i][0], cell[1] + indices[i][1]]; 
    arr.push(c);
  }
  return arr;
};

exports.equal = mattUtil.equal;
