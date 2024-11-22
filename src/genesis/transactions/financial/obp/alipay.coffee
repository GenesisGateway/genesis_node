
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'
NumberValidator  = require '../../../helpers/validators/number_validator'

class Alipay extends FinancialBase

  getTransactionType: ->
    TransactionTypes.ALIPAY

  constructor: (params, configuration) ->
    super params, configuration

module.exports = Alipay
