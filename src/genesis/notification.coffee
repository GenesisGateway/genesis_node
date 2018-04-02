crypto      = require 'crypto'
config      = require 'config'
http        = require 'http'
util        = require 'util'
connect     = require 'connect'
xmlObj      = require 'xml-object'
bodyParser  = require 'body-parser'

Transaction = require './transaction'

class Notification

  constructor: ->
    @callbacks = { }
    @listener  = { }

  ###
    Setup a listener for incoming notification requests
  ###
  listen: (onSuccess, onFailure) ->

    @callbacks =
      success:
        onSuccess
      failure:
        onFailure

    args = config.notifications

    @listener = args

    listener = connect()

    listener.use bodyParser.urlencoded { extended: true }

    listener.use args.path, (request, response) =>
      try
        params = request.body

        @verifySignature params

        @reconcile params

        response.setHeader(
          'Content-Type', 'text/xml'
        )
        response.write(
          @echoConfirmation params
        )
      catch Error
        response.writeHead 400

        console.error Error
      finally
        response.end ''

    server = http.createServer listener
    server.listen args.port, args.host

    console.log(
      util.format '[notifier] listen on: %s:%s%s', args.host, args.port, args.path
    )

  ###
    Initiate a reconcile with Genesis Gateway

    If successful, it will initiate the callback with the body
  ###
  reconcile: (params) ->

    transaction = new Transaction()

    if params.wpf_unique_id
      transaction.wpf_reconcile {
        unique_id:
          params.wpf_unique_id
      }
      .send()
      .then @callbacks.success
      .catch @callbacks.failure
    else
      transaction.reconcile {
        unique_id:
          params.unique_id
      }
      .send()
      .then @callbacks.success
      .catch @callbacks.failure

  ###
    Respond to Genesis as expected
  ###
  echoConfirmation: (params) ->

    if params.wpf_unique_id
      response_body = {
        notification_echo:
          'wpf_unique_id':
            params.wpf_unique_id
      }
    else
      response_body = {
        notification_echo:
          'unique_id':
            params.unique_id
      }

    return xmlObj response_body, declaration: true

  ###
    Verify an incoming request's signature
  ###
  verifySignature: (params) ->

    if !params.signature
      throw new Error 'Invalid Signature'

    if params.unique_id
      unique_id = params.unique_id
    else if params.wpf_unique_id
      unique_id = params.wpf_unique_id
    else
      unique_id = new String

    switch params.signature.length
      when 40  then hash = crypto.
                            createHash('sha1').
                            update(unique_id + config.customer.password).
                            digest('hex')
      when 128 then hash = crypto.
                            createHash('sha512').
                            update(unique_id + config.customer.password).
                            digest('hex')
      else hash = new String

    if hash.toString() isnt params.signature.toString()
      throw new Error 'Invalid Signature'

  getUrl: () =>
    util.format 'http://%s:%s%s'
    , @listener.host
    , @listener.port
    , @listener.path

module.exports = Notification