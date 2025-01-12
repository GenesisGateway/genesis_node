// Generated by CoffeeScript 2.7.0
(function() {
  var Cancel, FinancialBase, TransactionTypes;

  FinancialBase = require('./financial_base');

  TransactionTypes = require('../../helpers/transaction/types');

  Cancel = class Cancel extends FinancialBase {
    getTransactionType() {
      return TransactionTypes.VOID;
    }

  };

  module.exports = Cancel;

}).call(this);
