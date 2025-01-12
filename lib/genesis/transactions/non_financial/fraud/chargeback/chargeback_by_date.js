// Generated by CoffeeScript 2.7.0
(function() {
  var Base, ChargebackByDate;

  Base = require('../../../base');

  ChargebackByDate = class ChargebackByDate extends Base {
    getTransactionType() {
      return 'chargeback_by_date_request';
    }

    getData() {
      return this.params;
    }

    getUrl() {
      return {
        app: 'gate',
        path: 'chargebacks/by_date'
      };
    }

    getTrxData() {
      return {
        'chargeback_request': this.params
      };
    }

  };

  module.exports = ChargebackByDate;

}).call(this);
