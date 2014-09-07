/**
 * Bootstrapping submodule for the server.
 *
 * @module mystic-noggin
 * @submodule server
 * @public
 * @requires {module} util
 * @requires {submodule} server/app-config
 * @requires {submodule} server/logger
 * @requires {submodule} server/hapi-server
 * @requires {submodule} server/database/connection
 */
var util = require('util'),
    config = require('./app-config'),
    logger = require('./logger').logger,
    server = require('./hapi-server'),
    database = require('./database/connection');

server.start();
database.start();

logger.misc.debug('///////////////////////////////');
logger.misc.debug('///////    Config...    ///////');
logger.misc.debug('.app => ', config.app);
logger.misc.debug('.server => ', config.server);
logger.misc.debug('.logger => ', config.logger);
logger.misc.debug('.database => ', config.database);
logger.misc.debug('///////    ...Config    ///////');
logger.misc.debug('///////////////////////////////');
