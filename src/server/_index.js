var config = require('./app-config'),
    logger = require('./logger');

require('./hapi-server');

logger.log('debug', 'Config...');
logger.log('debug', '.app', config.app);
logger.log('debug', '.server', config.server);
logger.log('debug', '.logger', config.logger);
logger.log('debug', '...Config');
