var assert = require("assert");
var conway = require("../conway.js");

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

exports['empty board is stable'] = function(){
  assert.equal(true, conway.equal([], conway.evolve([])));
};

exports['empty square is stable'] = function(){
  assert.equal(true, conway.equal([[1,1], [1,2], [2,1], [2,2]].sort(),
                                  conway.evolve([[1,1], [1,2], [2,1], [2,2]])));
};
