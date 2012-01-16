var util = require("util");

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
      nextGen.push(explode(k));
    }
  }
  return nextGen.sort();
};

function explode(str) {
  var ret = str.split(",");
  for (var i = 0; i < ret.length; i++) {
    ret[i] = Number(ret[i]);
  }
  return ret;
}
exports.neighbors = function(cell) {
  var indices = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];
  var arr = [];
  for (var i = 0; i < 8; i++){
    var c = [cell[0] + indices[i][0], cell[1] + indices[i][1]]; 
    arr.push(c);
  }
  return arr;
};

function equal(o1, o2) {
  // js has a retarded == operator, which says [] != []
  // this operator does structural equality, so that two
  // arrays that print the same will be equal.
  if ([].constructor != Array && [].constructor != Object) {
    return o1 == o2;
  } else if (o1.length != o2.length) {
    return false;
  } else if ([].constructor === Array){
    for(var i = 0; i < o1.length; i++) {
      if (!equal(o1[i], o2[i])){
        return false;
      }
    }
  } else if (o1.constructor === Object) {
    for(k in o1) {
      if (!equal(o1[k], o2[k])) {
        return false;
      }
    }
  } else {
    return false; // don't know what to do with other types
  }
  return true;
}

exports.equal = equal;
