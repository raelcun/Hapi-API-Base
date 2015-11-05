(function() {
  module.exports = {
    env: 'development',
    mongo: {
      connection: {
        username: 'node',
        password: 'node',
        hostname: '192.168.33.10',
        port: 27017,
        database: 'inspire-me'
      },
      settings: {
        server: {
          socketOptions: {
            keepAlive: 1,
            connectTimeoutMS: 30000
          }
        }
      },
      logDB: {
        username: 'node',
        password: 'node',
        hostname: '192.168.33.10',
        port: 27017,
        database: 'inspire-me',
        collection: 'logs'
      }
    }
  };

}).call(this);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImNvbmZpZy9lbnYvZGV2ZWxvcG1lbnQuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0VBQUEsTUFBTSxDQUFDLE9BQVAsR0FDRTtJQUFBLEdBQUEsRUFBSyxhQUFMO0lBRUEsS0FBQSxFQUNFO01BQUEsVUFBQSxFQUNFO1FBQUEsUUFBQSxFQUFVLE1BQVY7UUFDQSxRQUFBLEVBQVUsTUFEVjtRQUVBLFFBQUEsRUFBVSxlQUZWO1FBR0EsSUFBQSxFQUFNLEtBSE47UUFJQSxRQUFBLEVBQVUsWUFKVjtPQURGO01BTUEsUUFBQSxFQUNFO1FBQUEsTUFBQSxFQUNFO1VBQUEsYUFBQSxFQUNFO1lBQUEsU0FBQSxFQUFXLENBQVg7WUFDQSxnQkFBQSxFQUFrQixLQURsQjtXQURGO1NBREY7T0FQRjtNQVdBLEtBQUEsRUFDRTtRQUFBLFFBQUEsRUFBVSxNQUFWO1FBQ0EsUUFBQSxFQUFVLE1BRFY7UUFFQSxRQUFBLEVBQVUsZUFGVjtRQUdBLElBQUEsRUFBTSxLQUhOO1FBSUEsUUFBQSxFQUFVLFlBSlY7UUFLQSxVQUFBLEVBQVksTUFMWjtPQVpGO0tBSEY7O0FBREYiLCJmaWxlIjoiY29uZmlnL2Vudi9kZXZlbG9wbWVudC5qcyIsInNvdXJjZVJvb3QiOiIvc291cmNlLyIsInNvdXJjZXNDb250ZW50IjpbIm1vZHVsZS5leHBvcnRzID1cbiAgZW52OiAnZGV2ZWxvcG1lbnQnXG5cbiAgbW9uZ286XG4gICAgY29ubmVjdGlvbjpcbiAgICAgIHVzZXJuYW1lOiAnbm9kZSdcbiAgICAgIHBhc3N3b3JkOiAnbm9kZSdcbiAgICAgIGhvc3RuYW1lOiAnMTkyLjE2OC4zMy4xMCdcbiAgICAgIHBvcnQ6IDI3MDE3XG4gICAgICBkYXRhYmFzZTogJ2luc3BpcmUtbWUnXG4gICAgc2V0dGluZ3M6XG4gICAgICBzZXJ2ZXI6XG4gICAgICAgIHNvY2tldE9wdGlvbnM6XG4gICAgICAgICAga2VlcEFsaXZlOiAxXG4gICAgICAgICAgY29ubmVjdFRpbWVvdXRNUzogMzAwMDBcbiAgICBsb2dEQjpcbiAgICAgIHVzZXJuYW1lOiAnbm9kZSdcbiAgICAgIHBhc3N3b3JkOiAnbm9kZSdcbiAgICAgIGhvc3RuYW1lOiAnMTkyLjE2OC4zMy4xMCdcbiAgICAgIHBvcnQ6IDI3MDE3XG4gICAgICBkYXRhYmFzZTogJ2luc3BpcmUtbWUnXG4gICAgICBjb2xsZWN0aW9uOiAnbG9ncyciXX0=
