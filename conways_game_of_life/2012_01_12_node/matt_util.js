function equal(o1, o2) {
  // js has a retarded == operator, which says [] != []
  // this operator does structural equality, so that two
  // arrays that print the same will be equal.
  if (o1.constructor != o2.constructor) {
    return false;
  } else if (o1.constructor != Array && o1.constructor != Object) {
    return o1 === o2;
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

exports.splitToNumbers = function(str) {
  var ret = str.split(",");
  for (var i = 0; i < ret.length; i++) {
    ret[i] = Number(ret[i]);
  }
  return ret;
};
