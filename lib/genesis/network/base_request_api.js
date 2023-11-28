// Generated by CoffeeScript 2.7.0
(function() {
  var BaseRequestApi, Response;

  Response = require('../response');

  BaseRequestApi = class BaseRequestApi {
    constructor() {
      this.response = new Response();
    }

    doRequest(httpClient, requestObject) {
      return new Promise((function(resolve, reject) {
        return httpClient(requestObject).then((function(httpResponse) {
          return resolve(this.response.process(httpResponse));
        }).bind(this)).catch((function(errorObject) {
          return reject(this.parseErrorObject(errorObject));
        }).bind(this));
      }).bind(this));
    }

    parseErrorObject(errorObject) {
      if (errorObject.response) {
        return {
          status: errorObject.response.status,
          message: errorObject.response.statusText,
          response: this.response.process(errorObject.response)
        };
      }
      if (errorObject.request) {
        return {
          status: errorObject.code,
          message: 'No response received from hostname: ' + errorObject.hostname,
          response: errorObject.response
        };
      }
      return {
        status: 'Unknown',
        message: errorObject.message,
        response: void 0
      };
    }

  };

  module.exports = BaseRequestApi;

}).call(this);