var assert = require("assert");
var conway = require("../conway.js");

// function evolve(liveCells) {
//   return liveCells;
// }

// function equal(cellSet1, cellSet2) {
//   // js has a retarded == operator, which says [] != []
//   // this operator does structural equality, so that two
//   // arrays that print the same will be equal.
//   if ([].constructor != Array && [].constructor != Object) {
//     return cellSet1 == cellSet2;
//   } else if (cellSet1.length != cellSet2.length) {
//     return false;
//   } else if ([].constructor === Array){
//     for(var i = 0; i < cellSet1.length; i++) {
//       if (!equal(cellSet1[i], cellSet2[i])){
//         return false;
//       }
//     }
//   } else if (cellSet1.constructor === Object) {
//     for(k in cellSet1) {
//       if (!equal(cellSet1[k], cellSet2[k])) {
//         return false;
//       }
//     }
//   } else {
//     return false; // don't know what to do with other types
//   }
//   return true;
// }

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
  assert.equal(true, conway.equal([[1,1], [1,2], [2,1], [2,2]],
                           conway.evolve([[1,1], [1,2], [2,1], [2,2]])));
};

exports['lonely board dies'] = function(){
  assert.equal(true, conway.equal([], conway.evolve([[1,1]])));
};
