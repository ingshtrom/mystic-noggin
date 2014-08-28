var path = require('path');

module.exports.server = {
  port: 3000
};

module.exports.logger = {
  defaultLogFile: path.resolve(global.appRoot, "logs", "mystic-noggin.log"),
  logLevel: "info",
  maxFileSize: 102400
};
