exports.evolve = function(liveCells) {
  return liveCells;
}

function equal(cellSet1, cellSet2) {
  // js has a retarded == operator, which says [] != []
  // this operator does structural equality, so that two
  // arrays that print the same will be equal.
  if ([].constructor != Array && [].constructor != Object) {
    return cellSet1 == cellSet2;
  } else if (cellSet1.length != cellSet2.length) {
    return false;
  } else if ([].constructor === Array){
    for(var i = 0; i < cellSet1.length; i++) {
      if (!equal(cellSet1[i], cellSet2[i])){
        return false;
      }
    }
  } else if (cellSet1.constructor === Object) {
    for(k in cellSet1) {
      if (!equal(cellSet1[k], cellSet2[k])) {
        return false;
      }
    }
  } else {
    return false; // don't know what to do with other types
  }
  return true;
}

exports.equal = equal;
