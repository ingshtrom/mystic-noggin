var config = require('./app-config'),
    logger = require('./logger').logger,
    util = require('util');

require('./hapi-server');

logger.misc.debug('Config...');
logger.misc.debug('.app', config.app);
logger.misc.debug('.server', config.server);
logger.misc.debug('.logger', config.logger);
logger.misc.debug('...Config');
