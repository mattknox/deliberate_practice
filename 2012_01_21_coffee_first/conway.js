(function() {
  var conway, mattUtil;

  mattUtil = require("./mattUtil.js");

  conway = {
    evolve: function(liveCells) {
      return liveCells;
    },
    equal: mattUtil.equal
  };

  exports.evolve = conway.evolve;

  exports.equal = conway.equal;

}).call(this);
