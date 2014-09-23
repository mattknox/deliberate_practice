(function () {
   this.passed = true;
   function assert(desc, test_function) {
     var result = test_function();
     passed = passed && result;
     return result && console.info(desc);
   }
 })();
