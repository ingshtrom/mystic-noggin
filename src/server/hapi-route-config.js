module.exports.config = function(server) {
  server.route({
      method: 'GET',
      path: '/',
      handler: function (request, reply) {
          reply('Hello, world!');
      }
  });

  return server;
};
