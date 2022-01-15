// Generated by CoffeeScript 2.5.1
(function() {
  var Promise, Request, Response, _, axios, config, fs, https, js2xml, path, util;

  _ = require('underscore');

  fs = require('fs');

  path = require('path');

  util = require('util');

  config = require('config');

  js2xml = require('js2xmlparser');

  axios = require('axios');

  https = require('https');

  Response = require('./response');

  Promise = require('bluebird');

  Request = (function() {
    var ENVIRONMENT_PREFIX_PRODUCTION, ENVIRONMENT_PREFIX_STAGING;

    class Request {
      constructor() {
        this.response = new Response();
      }

      /*
        Format and return the endpoint URL based on the transaction parameters
      */
      formatUrl(params) {
        if (params.token) {
          return util.format('%s://%s%s.%s/%s/%s', config.gateway.protocol, this.getURLEnvironment(), params.app, config.gateway.hostname, params.path, params.token);
        } else {
          return util.format('%s://%s%s.%s/%s', config.gateway.protocol, this.getURLEnvironment(), params.app, config.gateway.hostname, params.path);
        }
      }

      /*
        Convert Object to XML structure
      */
      objToXml(structure) {
        var rootNode;
        rootNode = _.first(_.keys(structure));
        return js2xml.parse(rootNode, structure[rootNode]);
      }

      /*
        Send the transaction to the Gateway
      */
      send(params) {
        var requestConfig;
        requestConfig = {
          method: 'POST',
          httpsAgent: new https.Agent({
            rejectUnauthorized: true,
            maxVersion: "TLSv1.2",
            minVersion: "TLSv1.2"
          }),
          headers: {
            'Content-Type': 'text/xml',
            'User-Agent': 'Genesis Node.js client v' + config.module.version,
            'Authorization': 'Basic ' + Buffer.from(config.customer.username + ':' + config.customer.password).toString('base64')
          },
          timeout: Number(config.gateway.timeout),
          validateStatus: function(status) {
            return status >= 200 && status < 300;
          }
        };
        return new Promise((function(resolve, reject) {
          return axios.post(this.formatUrl(params.url), this.objToXml(params.trx), requestConfig).then((function(httpResponse) {
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

      getURLEnvironment() {
        if (config.gateway.testing) {
          return ENVIRONMENT_PREFIX_STAGING + '.';
        } else {
          return ENVIRONMENT_PREFIX_PRODUCTION;
        }
      }

    };

    ENVIRONMENT_PREFIX_PRODUCTION = '';

    ENVIRONMENT_PREFIX_STAGING = 'staging';

    return Request;

  }).call(this);

  module.exports = Request;

}).call(this);