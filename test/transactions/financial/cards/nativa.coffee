faker       = require 'faker'
path        = require 'path'
_           = require 'underscore'
Currency    = require path.resolve './src/genesis/helpers/currency'
FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/cards/nativa'

describe 'Nativa Transaction', ->

  before ->
    @data                     = (new FakeData).getMinimumData()
    @data.currency            = faker.random.arrayElement (new Currency).getCurrencies()
    @data.amount              = faker.datatype.number().toString()
    @data.customer_email      = faker.internet.email()
    @data.return_success_url  = faker.internet.url()
    @data.return_failure_url  = faker.internet.url()
    @data.remote_ip           = faker.internet.ip()
    @data.consumer_reference  = 'Consumer Reference'
    @data.national_id         = '8812128812'
    @data.birth_date          = '30-12-1992'
    @data.billing_address     = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      country: 'AR'
    }

    @data.shipping_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      country: 'AR'
    }

    @transaction              = new Transaction()

  context 'with valid request', ->

    it 'works when existing country code parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'AR'

      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails when wrong country parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'US'

      assert.equal false, @transaction.setData(data).isValid()
