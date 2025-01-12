faker = require 'faker'
_     = require 'underscore'

SubsequentRecurringAttributes = () ->
  context 'when Recurring Type - subsequent', ->

    it 'with reference_id', ->
      data = _.clone @data
      data.recurring_type = 'subsequent'
      data.reference_id = faker.datatype.number().toString()

      assert.equal true, @transaction.setData(data).isValid()

    it 'works without reference_id', ->
      data = _.clone @data
      data.recurring_type = 'subsequent'
      delete data.reference_id

      assert.equal true, @transaction.setData(data).isValid()

    it 'without card parameters', ->
      data = _.clone @data
      data.recurring_type = 'subsequent'
      data.reference_id = faker.datatype.number().toString()

      delete data.card_holder
      delete data.card_number
      delete data.expiration_date
      delete data.expiration_month
      delete data.cvv

      assert.equal true, @transaction.setData(data).isValid()

    it 'without currency parameter', ->
      data = _.clone @data
      data.recurring_type = 'subsequent'
      data.reference_id = faker.datatype.number().toString()

      delete data.card_holder
      delete data.card_number
      delete data.expiration_date
      delete data.expiration_month
      delete data.cvv
      delete data.currency

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with minimum data', ->
      data = _.clone @data
      data.recurring_type = 'subsequent'

      delete data.reference_id
      delete data.card_holder
      delete data.card_number
      delete data.expiration_date
      delete data.expiration_month
      delete data.cvv
      delete data.currency
      delete data.consumer_id
      delete data.token
      delete data.remember_card

      assert.equal true, @transaction.setData(data).isValid()

module.exports = SubsequentRecurringAttributes
