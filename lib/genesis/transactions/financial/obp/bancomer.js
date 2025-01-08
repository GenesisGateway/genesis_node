// Generated by CoffeeScript 2.7.0
(function() {
  var Bancomer, FinancialBase, TransactionTypes, _;

  FinancialBase = require('../financial_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  _ = require('underscore');

  Bancomer = class Bancomer extends FinancialBase {
    getTransactionType() {
      return TransactionTypes.BANCOMER;
    }

  };

  module.exports = Bancomer;

}).call(this);