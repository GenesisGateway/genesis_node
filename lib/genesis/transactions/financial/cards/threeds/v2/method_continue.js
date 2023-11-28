// Generated by CoffeeScript 2.7.0
(function() {
  var Currency, MethodContinue, Request, ThreedsUtils, TransactionTypes, _;

  _ = require('underscore');

  ThreedsUtils = require('../../../../../utils/threeds_utils');

  Request = require('../../../../../request');

  Currency = require('../../../../../helpers/currency');

  TransactionTypes = require('../../../../../helpers/transaction/types');

  MethodContinue = (function() {
    /*
      Returns relative path with provided unique_id
    */
    var getRelativePath;

    class MethodContinue extends Request {
      constructor(params) {
        super('form');
        this.params = params;
        this.currency = new Currency();
      }

      getTransactionType() {
        return TransactionTypes.METHOD_CONTINUE;
      }

      setData(params) {
        this.params = params;
        return this;
      }

      /*
         Returns SHA512 hash of а concatenated string (unique_id, amount, timestamp, customer.password)
      */
      getSignature() {
        this.params.amount = this.currency.convertToMinorUnits(this.params.amount, this.params.currency);
        return ThreedsUtils.generateSignature(this.params.unique_id, this.params.amount, this.params.timestamp);
      }

      getData() {
        return this.params;
      }

      getTrxParams() {
        return {
          unique_id: this.params.unique_id,
          signature: this.getSignature()
        };
      }

      getArguments() {
        return {
          trx: this.getTrxParams(),
          url: {
            app: 'gate',
            path: getRelativePath.call(this)
          }
        };
      }

    };

    MethodContinue.prototype.THREEDS_METHOD_URL = 'threeds/threeds_method/';

    getRelativePath = function() {
      return this.THREEDS_METHOD_URL + this.params.unique_id;
    };

    return MethodContinue;

  }).call(this);

  module.exports = MethodContinue;

}).call(this);