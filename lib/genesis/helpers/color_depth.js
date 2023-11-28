// Generated by CoffeeScript 2.7.0
(function() {
  var ColorDepth, _;

  _ = require("underscore");

  ColorDepth = class ColorDepth {
    constructor() {
      this.colorDepth = {
        'BIT_1': 1,
        'BITS_4': 4,
        'BITS_8': 8,
        'BITS_15': 15,
        'BITS_16': 16,
        'BITS_24': 24,
        'BITS_32': 32,
        'BITS_48': 48
      };
    }

    getColorDepth() {
      return _.values(this.colorDepth);
    }

    handleColorDepth(colorDepthValue) {
      if (colorDepthValue === null) {
        return false;
      }
      if (colorDepthValue > 0) {
        return (this.getColorDepth().filter(function(x) {
          return x <= colorDepthValue;
        })).reverse()[0];
      }
      return colorDepthValue;
    }

  };

  module.exports = ColorDepth;

}).call(this);