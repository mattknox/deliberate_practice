var assert = require("assert");

function evolve(liveCells) {
  return liveCells;
}

function equal(cellSet1, cellSet2) {
  // js has a retarded == operator, which says [] != []
  if (cellSet1.length != cellSet2.length) {
    return false;
  } else {
    for(var i = 0; i < cellSet1.length; i++) {
      if (cellSet1[i] != cellSet2[i]){
        return false;
      }
    }
  }
  return true;
}

exports['equal([], []) => true'] = function(){
  assert.equal(true, equal([], []));
};

exports['equal([1], [1] => true'] = function(){
  assert.equal(true, equal([1], [1]));
};

exports['equal([1], [1, 2] => false'] = function(){
  assert.equal(false, equal([1], [1, 2]));
};

exports['equal([1, 2], [1, 2] => true'] = function(){
  assert.equal(true, equal([1,2], [1, 2]));
};

exports['empty board is stable'] = function(){
  assert.equal(true, equal([], evolve([])));
};
