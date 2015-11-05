(function() {
  var boom, config, hapi, jwt, logger, server, util;

  require('source-map-support').install();

  hapi = require('hapi');

  config = require('./config/env');

  logger = require('./components/logger');

  util = require('./components/util');

  boom = require('./components/boom');

  jwt = require('jsonwebtoken');

  logger.debug(jwt.sign({
    username: 'admin',
    scope: 'user'
  }, config.API.JWTSecret, {
    algorithm: 'HS512'
  }));

  server = new hapi.Server();

  server.connection(config.server);


  /*
  If authorization passed, validate host and remote ip
  unless token is for admin user
   */

  server.ext('onPreAuth', function(request, reply) {
    var authorization, parts, tokenPayload;
    authorization = request.raw.req.headers.authorization;
    parts = authorization != null ? authorization.split(/\s+/) : void 0;
    if ((parts != null) && parts.length === 2 && parts[0].toLowerCase() === 'bearer') {
      tokenPayload = jwt.decode(parts[1]);
      if ((tokenPayload != null ? tokenPayload.scope : void 0) !== 'admin' && ((tokenPayload != null ? tokenPayload.remoteAddress : void 0) !== request.info.remoteAddress || (tokenPayload != null ? tokenPayload.host : void 0) !== request.info.host)) {
        return reply(boom.unauthorized('Invalid token'));
      }
    }
    return reply["continue"]();
  });

  server.register([
    {
      register: require('hapi-auth-jwt2')
    }, {
      register: require('good'),
      options: config.goodOptions
    }
  ], function(err) {
    if (err) {
      logger.error('Error loading plugins', err, function() {
        return process.exit(0);
      });
    }
    server.auth.strategy('jwt', 'jwt', true, {
      key: config.API.JWTSecret,
      verifyOptions: {
        algorithms: ['HS512']
      },
      validateFunc: function(decoded, request, cb) {
        var ref;
        if ((ref = decoded.username) === 'dan' || ref === 'admin') {
          return cb(null, true, decoded);
        } else {
          return cb(null, false, {});
        }
      }
    });
    server.auth.scope = ['admin', 'user'];
    require('./routes')(server);
    return server.start(function() {
      return logger.info("web interface started at " + config.server.host + ":" + config.server.port + " in " + config.env + " mode");
    });
  });

}).call(this);

//# sourceMappingURL=data:application/json;base64,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QUFBLENBQUcsSUFBSCxFQUFTLEtBQVQsRUFBZ0IsRUFBaEIsRUFIVDs7TUFEWSxDQUp5QjtLQUF6QztJQVVBLE1BQU0sQ0FBQyxJQUFJLENBQUMsS0FBWixHQUFvQixDQUFDLE9BQUQsRUFBVSxNQUFWO0lBR3BCLE9BQUEsQ0FBUSxVQUFSLENBQUEsQ0FBb0IsTUFBcEI7V0FFQSxNQUFNLENBQUMsS0FBUCxDQUFhLFNBQUE7YUFDWCxNQUFNLENBQUMsSUFBUCxDQUFZLDJCQUFBLEdBQTRCLE1BQU0sQ0FBQyxNQUFNLENBQUMsSUFBMUMsR0FBK0MsR0FBL0MsR0FBa0QsTUFBTSxDQUFDLE1BQU0sQ0FBQyxJQUFoRSxHQUFxRSxNQUFyRSxHQUEyRSxNQUFNLENBQUMsR0FBbEYsR0FBc0YsT0FBbEc7SUFEVyxDQUFiO0VBbkJDLENBVEg7QUE1QkEiLCJmaWxlIjoiYXBwLmpzIiwic291cmNlUm9vdCI6Ii9zb3VyY2UvIiwic291cmNlc0NvbnRlbnQiOlsicmVxdWlyZSgnc291cmNlLW1hcC1zdXBwb3J0JykuaW5zdGFsbCgpXG5cbmhhcGkgPSByZXF1aXJlKCdoYXBpJylcbmNvbmZpZyA9IHJlcXVpcmUoJy4vY29uZmlnL2VudicpXG5sb2dnZXIgPSByZXF1aXJlKCcuL2NvbXBvbmVudHMvbG9nZ2VyJylcbnV0aWwgPSByZXF1aXJlKCcuL2NvbXBvbmVudHMvdXRpbCcpXG5ib29tID0gcmVxdWlyZSgnLi9jb21wb25lbnRzL2Jvb20nKVxuand0ID0gcmVxdWlyZSgnanNvbndlYnRva2VuJylcblxuIyBlY2hvIGFkbWluIHRva2VuIGZvciB0ZXN0aW5nIHB1cnBvc2VzXG5sb2dnZXIuZGVidWcoand0LnNpZ24oeyB1c2VybmFtZTogJ2FkbWluJywgc2NvcGU6ICd1c2VyJyB9LCBjb25maWcuQVBJLkpXVFNlY3JldCwgeyBhbGdvcml0aG06ICdIUzUxMicgfSkpXG5cbnNlcnZlciA9IG5ldyBoYXBpLlNlcnZlcigpXG5zZXJ2ZXIuY29ubmVjdGlvbihjb25maWcuc2VydmVyKVxuXG4jIyNcbklmIGF1dGhvcml6YXRpb24gcGFzc2VkLCB2YWxpZGF0ZSBob3N0IGFuZCByZW1vdGUgaXBcbnVubGVzcyB0b2tlbiBpcyBmb3IgYWRtaW4gdXNlclxuIyMjXG5zZXJ2ZXIuZXh0ICdvblByZUF1dGgnLCAocmVxdWVzdCwgcmVwbHkpIC0+XG4gIGF1dGhvcml6YXRpb24gPSByZXF1ZXN0LnJhdy5yZXEuaGVhZGVycy5hdXRob3JpemF0aW9uXG4gIHBhcnRzID0gYXV0aG9yaXphdGlvbj8uc3BsaXQoL1xccysvKVxuICBpZiBwYXJ0cz8gYW5kIHBhcnRzLmxlbmd0aCBpcyAyIGFuZCBwYXJ0c1swXS50b0xvd2VyQ2FzZSgpIGlzICdiZWFyZXInXG4gICAgdG9rZW5QYXlsb2FkID0gand0LmRlY29kZShwYXJ0c1sxXSlcbiAgICBpZiB0b2tlblBheWxvYWQ/LnNjb3BlIGlzbnQgJ2FkbWluJyBhbmQgKHRva2VuUGF5bG9hZD8ucmVtb3RlQWRkcmVzcyBpc250IHJlcXVlc3QuaW5mby5yZW1vdGVBZGRyZXNzIG9yIHRva2VuUGF5bG9hZD8uaG9zdCBpc250IHJlcXVlc3QuaW5mby5ob3N0KVxuICAgICAgcmV0dXJuIHJlcGx5KGJvb20udW5hdXRob3JpemVkKCdJbnZhbGlkIHRva2VuJykpXG4gIHJlcGx5LmNvbnRpbnVlKClcblxuc2VydmVyLnJlZ2lzdGVyIFtcbiAgeyByZWdpc3RlcjogcmVxdWlyZSgnaGFwaS1hdXRoLWp3dDInKSB9XG4gIHsgcmVnaXN0ZXI6IHJlcXVpcmUoJ2dvb2QnKSwgb3B0aW9uczogY29uZmlnLmdvb2RPcHRpb25zIH1cbiAgIyB7XG4gICMgICByZWdpc3RlcjogcmVxdWlyZSgnaGFwaS1tb25nb2RiJylcbiAgIyAgIG9wdGlvbnM6XG4gICMgICAgIHVybDogdXRpbC5jb25zdHJ1Y3RNb25nb1VSSS5hcHBseShjb25maWcubW9uZ28uY29ubmVjdGlvbilcbiAgIyAgICAgc2V0dGluZ3M6IGNvbmZpZy5tb25nby5zZXR0aW5ncy5zZXJ2ZXJcbiAgIyB9XG5dLCAoZXJyKSAtPlxuICBpZiBlcnIgdGhlbiBsb2dnZXIuZXJyb3IgJ0Vycm9yIGxvYWRpbmcgcGx1Z2lucycsIGVyciwgLT4gcHJvY2Vzcy5leGl0KDApXG5cbiAgIyBzZXR1cCBhdXRob3JpemF0aW9uIHN0cmF0ZWd5XG4gIHNlcnZlci5hdXRoLnN0cmF0ZWd5ICdqd3QnLCAnand0JywgdHJ1ZSwge1xuICAgIGtleTogY29uZmlnLkFQSS5KV1RTZWNyZXRcbiAgICB2ZXJpZnlPcHRpb25zOlxuICAgICAgYWxnb3JpdGhtczogWydIUzUxMiddXG4gICAgdmFsaWRhdGVGdW5jOiAoZGVjb2RlZCwgcmVxdWVzdCwgY2IpIC0+XG4gICAgICBpZiBkZWNvZGVkLnVzZXJuYW1lIGluIFsnZGFuJywgJ2FkbWluJ11cbiAgICAgICAgcmV0dXJuIGNiKG51bGwsIHRydWUsIGRlY29kZWQpXG4gICAgICBlbHNlXG4gICAgICAgIHJldHVybiBjYihudWxsLCBmYWxzZSwge30pXG4gIH1cbiAgc2VydmVyLmF1dGguc2NvcGUgPSBbJ2FkbWluJywgJ3VzZXInXVxuXG4gICMgcmVxdWlyZSBhbGwgcm91dGVzXG4gIHJlcXVpcmUoJy4vcm91dGVzJykoc2VydmVyKVxuXG4gIHNlcnZlci5zdGFydCAtPlxuICAgIGxvZ2dlci5pbmZvIFwid2ViIGludGVyZmFjZSBzdGFydGVkIGF0ICN7Y29uZmlnLnNlcnZlci5ob3N0fToje2NvbmZpZy5zZXJ2ZXIucG9ydH0gaW4gI3tjb25maWcuZW52fSBtb2RlXCIiXX0=
