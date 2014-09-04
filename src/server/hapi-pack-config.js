var config = require('./app-config');

module.exports.config = function(server) {
  // config Good server logging for Hapi
  var options = {
      broadcastInterval: 1000,
      opsInterval: 60 * 1000,
      maxLogSize: config.logger.maxFileSize,
      subscribers: {
          'console':                ['ops', 'request', 'log', 'error']
      }
  };
  options.subscribers[config.logger.logDir] = ['ops', 'request', 'log', 'error'];

  server.pack.register({
      plugin: require('good'),
      options: options
  }, function (err) {
     if (err) {
        logger.error("'Good' logger error: " + err);
        return;
     }
  });

  return server;
};
