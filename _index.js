var path = require('path');
global.appRoot = path.resolve(__dirname);

require('./src/server/index.js');
