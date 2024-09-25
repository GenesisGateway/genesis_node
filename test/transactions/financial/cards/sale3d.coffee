path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData           = require '../../fake_data'
Transaction        = require path.resolve './src/genesis/transactions/financial/cards/sale3d'
ThreeDBase         = require './three_d_base'
BusinessAttributes = require '../../business_attributes'
ScaParams          = require '../../../examples/attributes/sca_params'
Moto               = require '../../../examples/attributes/financial/moto'
Gaming             = require '../../../examples/attributes/financial/gaming'
Crypto             = require '../../../examples/attributes/financial/crypto'
ThreedsV2          = require '../../../examples/attributes/threeds/v2/threeds_v2'
RecurringType      = require '../../../examples/attributes/financial/recurring_type'
ManagedRecurring   = require '../../../examples/attributes/financial/recurring/managed_recurring'
RiskParams         = require '../../../examples/attributes/risk_params'
DynamicDescriptor  = require '../../../examples/attributes/financial/dynamic_descriptor'
CredentialOnFile  = require '../../../examples/attributes/credential_on_file'
TravelData         = require '../../../examples/attributes/financial/travel_data/travel_data'
CSEncription       = require '../../../examples/attributes/client_side_encryption'
FundingAttributes  = require '../../../examples/attributes/financial/funding_attributes'
MpiParams          = require '../../../examples/attributes/threeds/v1/mpi_params'

describe 'Sale 3D Transaction', ->

  before ->
    @data = (new FakeData).getDataWithBusinessAttributes()

    @data['notification_url']   = faker.internet.url()
    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()
    @data['managed_recurring'] = (new FakeData).getManagedRecurringAutomatic()

    @transaction = new Transaction()

  ThreeDBase()
  BusinessAttributes()
  ScaParams()
  Moto()
  Gaming()
  Crypto()
  ThreedsV2()
  RecurringType()
  ManagedRecurring()
  RiskParams()
  DynamicDescriptor()
  CredentialOnFile()
  TravelData()
  CSEncription()
  FundingAttributes()
  MpiParams()
