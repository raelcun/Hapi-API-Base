(function() {
  var boom, config, jwt;

  config = require('../config/env');

  jwt = require('jsonwebtoken');

  boom = require('../components/boom');

  module.exports = {
    login: function(request, reply) {
      var password, ref, ref1, tokenPayload, username;
      username = (ref = request.payload) != null ? ref.username : void 0;
      password = (ref1 = request.payload) != null ? ref1.password : void 0;
      tokenPayload = {
        username: username,
        scope: username === 'admin' ? 'admin' : 'user',
        remoteAddress: request.info.remoteAddress,
        host: request.info.host
      };
      if ((username === 'admin' && password === 'admin') || (username === 'dan' && password === 'dan')) {
        return reply({
          token: jwt.sign(tokenPayload, config.API.JWTSecret, {
            expiresIn: config.APIOptions.defaultTokenExp
          })
        });
      } else {
        return reply(boom.unauthorized('Invalid username or password'));
      }
    }
  };

}).call(this);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImNvbnRyb2xsZXJzL2xvZ2luLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtBQUFBLE1BQUE7O0VBQUEsTUFBQSxHQUFTLE9BQUEsQ0FBUSxlQUFSOztFQUNULEdBQUEsR0FBTSxPQUFBLENBQVEsY0FBUjs7RUFDTixJQUFBLEdBQU8sT0FBQSxDQUFRLG9CQUFSOztFQUVQLE1BQU0sQ0FBQyxPQUFQLEdBQ0U7SUFBQSxLQUFBLEVBQU8sU0FBQyxPQUFELEVBQVUsS0FBVjtBQUNMLFVBQUE7TUFBQSxRQUFBLHdDQUEwQixDQUFFO01BQzVCLFFBQUEsMENBQTBCLENBQUU7TUFDNUIsWUFBQSxHQUNFO1FBQUEsUUFBQSxFQUFVLFFBQVY7UUFDQSxLQUFBLEVBQVUsUUFBQSxLQUFZLE9BQWYsR0FBNEIsT0FBNUIsR0FBeUMsTUFEaEQ7UUFFQSxhQUFBLEVBQWUsT0FBTyxDQUFDLElBQUksQ0FBQyxhQUY1QjtRQUdBLElBQUEsRUFBTSxPQUFPLENBQUMsSUFBSSxDQUFDLElBSG5COztNQUtGLElBQUcsQ0FBQyxRQUFBLEtBQVksT0FBWixJQUF3QixRQUFBLEtBQVksT0FBckMsQ0FBQSxJQUFpRCxDQUFDLFFBQUEsS0FBWSxLQUFaLElBQXNCLFFBQUEsS0FBWSxLQUFuQyxDQUFwRDtBQUNFLGVBQU8sS0FBQSxDQUFNO1VBQUUsS0FBQSxFQUFPLEdBQUcsQ0FBQyxJQUFKLENBQVMsWUFBVCxFQUF1QixNQUFNLENBQUMsR0FBRyxDQUFDLFNBQWxDLEVBQTZDO1lBQUUsU0FBQSxFQUFXLE1BQU0sQ0FBQyxVQUFVLENBQUMsZUFBL0I7V0FBN0MsQ0FBVDtTQUFOLEVBRFQ7T0FBQSxNQUFBO0FBR0UsZUFBTyxLQUFBLENBQU0sSUFBSSxDQUFDLFlBQUwsQ0FBa0IsOEJBQWxCLENBQU4sRUFIVDs7SUFUSyxDQUFQOztBQUxGIiwiZmlsZSI6ImNvbnRyb2xsZXJzL2xvZ2luLmpzIiwic291cmNlUm9vdCI6Ii9zb3VyY2UvIiwic291cmNlc0NvbnRlbnQiOlsiY29uZmlnID0gcmVxdWlyZSgnLi4vY29uZmlnL2VudicpXG5qd3QgPSByZXF1aXJlKCdqc29ud2VidG9rZW4nKVxuYm9vbSA9IHJlcXVpcmUoJy4uL2NvbXBvbmVudHMvYm9vbScpXG5cbm1vZHVsZS5leHBvcnRzID1cbiAgbG9naW46IChyZXF1ZXN0LCByZXBseSkgLT5cbiAgICB1c2VybmFtZSA9IHJlcXVlc3QucGF5bG9hZD8udXNlcm5hbWVcbiAgICBwYXNzd29yZCA9IHJlcXVlc3QucGF5bG9hZD8ucGFzc3dvcmRcbiAgICB0b2tlblBheWxvYWQgPVxuICAgICAgdXNlcm5hbWU6IHVzZXJuYW1lXG4gICAgICBzY29wZTogaWYgdXNlcm5hbWUgaXMgJ2FkbWluJyB0aGVuICdhZG1pbicgZWxzZSAndXNlcidcbiAgICAgIHJlbW90ZUFkZHJlc3M6IHJlcXVlc3QuaW5mby5yZW1vdGVBZGRyZXNzXG4gICAgICBob3N0OiByZXF1ZXN0LmluZm8uaG9zdFxuXG4gICAgaWYgKHVzZXJuYW1lIGlzICdhZG1pbicgYW5kIHBhc3N3b3JkIGlzICdhZG1pbicpIG9yICh1c2VybmFtZSBpcyAnZGFuJyBhbmQgcGFzc3dvcmQgaXMgJ2RhbicpXG4gICAgICByZXR1cm4gcmVwbHkoeyB0b2tlbjogand0LnNpZ24odG9rZW5QYXlsb2FkLCBjb25maWcuQVBJLkpXVFNlY3JldCwgeyBleHBpcmVzSW46IGNvbmZpZy5BUElPcHRpb25zLmRlZmF1bHRUb2tlbkV4cCB9KSB9KVxuICAgIGVsc2VcbiAgICAgIHJldHVybiByZXBseShib29tLnVuYXV0aG9yaXplZCgnSW52YWxpZCB1c2VybmFtZSBvciBwYXNzd29yZCcpKSJdfQ==
