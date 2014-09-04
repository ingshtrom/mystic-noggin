var winston = require('winston'),
    config = require('./app-config');

var consoleConfig, fileConfig;

// remove the default Console logger
winston.remove(winston.transports.Console);

// add our custom transports for all loggers
consoleConfig = {
  level: config.logger.logLevel,
  handleExceptions: true,
  colorize: true,
  timestamp: true
};
fileConfig = {
  filename: config.logger.defaultLogFile,
  level: config.logger.logLevel,
  maxsize: config.logger.maxFileSize,
  handleExceptions: true
};
winston.loggers.options.transports = [
  new (winston.transports.Console) (consoleConfig),
  new (winston.transports.File) (fileConfig)
];

// define different loggers... aka categories
// by providing this custom namespace, we have
// easy accessors to all of our custom loggers!
winston.mystic = {};

winston.loggers.add('api');
winston.mystic.api = winston.loggers.get('api');

winston.loggers.add('misc');
winston.mystic.misc = winston.loggers.get('misc');

// TODO(Alex.Hokanson): send an email when winston catches errors
winston.exitOnError = false;

module.exports.logger = winston.mystic;
