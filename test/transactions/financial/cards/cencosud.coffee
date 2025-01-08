faker       = require 'faker'
path        = require 'path'
_           = require 'underscore'
Currency    = require path.resolve './src/genesis/helpers/currency'
Country     = require path.resolve './src/genesis/helpers/country'
FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/cards/cencosud'

describe 'Cencosud Transaction', ->

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
      city: 'Buenos Aires',
      neighborhood: 'Buenos Aires',
      country: 'AR'
    }
    @data.shipping_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'Buenos Aires',
      neighborhood: 'Buenos Aires',
      country: faker.random.arrayElement (new Country).getCountries()
    }

    @transaction              = new Transaction()

  context 'with valid request', ->

    it 'works when valid country code parameter added', ->
      data = _.clone @data

      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails when not supported country parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'GR'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without required parameter consumer_reference', ->
      data = _.clone @data
      delete data.consumer_reference

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when consumer_reference is too long', ->
      data = _.clone @data
      data.consumer_reference = faker.datatype.string(25)

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without required parameter national_id', ->
      data = _.clone @data
      delete data.national_id

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when national_id is too long', ->
      data = _.clone @data
      data.national_id = faker.datatype.string(25)

      assert.equal false, @transaction.setData(data).isValid()