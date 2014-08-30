var path = require('path');

module.exports.app = {
  root: path.resolve(__dirname, '../../')
};

module.exports.server = {
  port: 3000
};

var logRoot = path.resolve(module.exports.app.root, 'logs');
module.exports.logger = {
  logDir: logRoot,
  defaultLogFile: path.resolve(logRoot, "mystic-noggin.log"),
  logLevel: "debug",
  maxFileSize: 102400
};
