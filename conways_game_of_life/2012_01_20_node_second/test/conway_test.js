var assert = require("assert");
var mattUtil = require("../matt_util.js");
var util = require("util");

function evolve(liveCells) {
  var liveMap = {};
  var neighborCounts = {};
  var nextGen = [];
  for(var i = 0; i < liveCells.length; i++) {
    liveMap[liveCells[i]] = true;
    var neighborList = neighbors(liveCells[i]);
    for(var j = 0; j < neighborList.length; j++) {
      var cellStr = neighborList[j];
      neighborCounts[cellStr] = (neighborCounts[cellStr] || 0) + 1;
    }
  }

  for(var s in neighborCounts) {
    var count = neighborCounts[s];
    if(3 == count || (2 == count && liveMap[s])) {
      nextGen.push(s);
    }
  }
  return nextGen.sort();
}

function neighbors(cellString) {
  var cell = cellString.split(",");
  var res = [];
  var indices = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];
  for(var i = 0; i < indices.length; i++) {
    var c = [indices[i][0] + Number(cell[0]), indices[i][1] + Number(cell[1])];
    res.push(c);
  }
  return res;
}

var conway = {
  equal: mattUtil.equal,
  evolve: evolve
};

exports['equal([], []) => true'] = function(){
  assert.equal(true, conway.equal([], []));
};

exports['equal([1], [1] => true'] = function(){
  assert.equal(true, conway.equal([1], [1]));
};

exports['equal([1], [1, 2] => false'] = function(){
  assert.equal(false, conway.equal([1], [1, 2]));
};

exports['equal([1, 2], [1, 2] => true'] = function(){
  assert.equal(true, conway.equal([1,2], [1, 2]));
};

exports['equal([[1], [2]], [[1], [2]] => true'] = function(){
  assert.equal(true, conway.equal([[1],[2]], [[1], [2]]));
};

exports["empty board is stable"] = function() {
  assert.equal(true, conway.equal([], conway.evolve([])));
};

exports["square board is stable"] = function() {
  assert.equal(true, conway.equal(["1,1","1,2","2,1","2,2"].sort(),
                                  conway.evolve(["1,1","1,2","2,1","2,2"])));
};

exports["lonely board dies"] = function () {
  assert.equal(true, conway.equal([], conway.evolve(["1,1"])));
};
