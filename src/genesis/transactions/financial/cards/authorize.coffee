
CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_ = require 'underscore'

class Authorize extends CardBase

  getTransactionType: ->
    TransactionTypes.AUTHORIZE

  isValid: () ->
    valid = super()

    if @params.recurring_type == 'subsequent' && _.isEmpty(@params.reference_id)
      @validator.addError
        type: 'required'
        property: 'reference_id'
        message: 'Field reference_id has invalid value. Field reference_id is required'

      return false

    valid

module.exports = Authorize
