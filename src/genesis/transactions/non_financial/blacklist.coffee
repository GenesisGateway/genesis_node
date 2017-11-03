
Base = require '../base'

class Blacklist extends Base

  constructor: (params) ->
    super params

    @requiredFields = [
      'card_number'
    ]

  getUrl: ->
    app:
      'gate'
    path:
      'blacklists'

  getTrxData: ->
    'blacklist_request':
      @params

module.exports = Blacklist