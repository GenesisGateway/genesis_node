// Generated by CoffeeScript 2.5.1
(function() {
  var AlternativeBase, PPRO, PaymentMethods, TransactionTypes, _;

  AlternativeBase = require('./alternative_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  PaymentMethods = require('../../../helpers/payment/methods');

  _ = require('underscore');

  PPRO = class PPRO extends AlternativeBase {
    getTransactionType() {
      return TransactionTypes.PPRO;
    }

    constructor(params) {
      super(params);
      this.paymentMethods = new PaymentMethods();
      this.requiredFields = _.union(this.requiredFields, ['payment_type']);
      this.fieldsValues['payment_type'] = this.paymentMethods.getMethods();
      this.requiredFieldsConditional = {
        'payment_type': {
          [`${PaymentMethods.GIRO_PAY}`]: ['bic', 'iban'],
          [`${PaymentMethods.PRZELEWY24}`]: ['customer_email'],
          [`${PaymentMethods.QIWI}`]: ['account_phone']
        }
      };
      this.fieldsValuesConditional = {
        'payment_type': {
          [`${PaymentMethods.EPS}`]: {
            'billing_address.country': 'AT',
            'currency': 'EUR'
          },
          [`${PaymentMethods.TELEINGRESO}`]: {
            'billing_address.country': 'ES',
            'currency': 'EUR'
          },
          [`${PaymentMethods.SAFETY_PAY}`]: {
            'billing_address.country': ['CA', 'MX', 'NI', 'CR', 'PA', 'CO', 'PE', 'BR', 'NL'],
            'currency': ['EUR', 'USD']
          },
          [`${PaymentMethods.TRUST_PAY}`]: {
            'billing_address.country': ['CZ', 'SK']
          },
          //'currency': ['CZK', 'EUR']
          [`${PaymentMethods.PRZELEWY24}`]: {
            'billing_address.country': 'PL',
            'currency': 'PLN'
          },
          [`${PaymentMethods.IDEAL}`]: {
            'billing_address.country': 'NL',
            'currency': 'EUR'
          },
          [`${PaymentMethods.QIWI}`]: {
            'billing_address.country': 'RU',
            'currency': ['EUR', 'RUB']
          },
          [`${PaymentMethods.GIRO_PAY}`]: {
            'billing_address.country': 'DE',
            'currency': 'EUR'
          },
          [`${PaymentMethods.BCMC}`]: {
            'billing_address.country': 'BE',
            'currency': 'EUR'
          },
          [`${PaymentMethods.MYBANK}`]: {
            'billing_address.country': ['BE', 'FR', 'IT', 'LU'],
            'currency': 'EUR'
          }
        },
        'billing_address.country': {
          'CZ': {
            'payment_type': {
              [`${PaymentMethods.TRUST_PAY}`]: {
                'currency': 'CZK'
              }
            }
          },
          'SK': {
            'payment_type': {
              [`${PaymentMethods.TRUST_PAY}`]: {
                'currency': 'EUR'
              }
            }
          }
        }
      };
    }

  };

  module.exports = PPRO;

}).call(this);