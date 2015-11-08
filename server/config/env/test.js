(function() {
  module.exports = {
    env: 'test',
    goodOptions: {
      responsePayload: false,
      reporters: [
        {
          reporter: require('good-console'),
          events: {
            request: 'error',
            log: '*',
            response: 'error',
            error: '*'
          }
        }
      ]
    },
    mongo: {
      connection: {
        database: 'inspire-me-test'
      },
      logDB: {
        database: 'inspire-me-test'
      }
    }
  };

}).call(this);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImNvbmZpZy9lbnYvdGVzdC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7RUFBQSxNQUFNLENBQUMsT0FBUCxHQUNFO0lBQUEsR0FBQSxFQUFLLE1BQUw7SUFFQSxXQUFBLEVBQ0U7TUFBQSxlQUFBLEVBQWlCLEtBQWpCO01BQ0EsU0FBQSxFQUFXO1FBQ1A7VUFBQSxRQUFBLEVBQVUsT0FBQSxDQUFRLGNBQVIsQ0FBVjtVQUNBLE1BQUEsRUFDRTtZQUFBLE9BQUEsRUFBUyxPQUFUO1lBQ0EsR0FBQSxFQUFLLEdBREw7WUFFQSxRQUFBLEVBQVUsT0FGVjtZQUdBLEtBQUEsRUFBTyxHQUhQO1dBRkY7U0FETztPQURYO0tBSEY7SUFhQSxLQUFBLEVBQ0U7TUFBQSxVQUFBLEVBQ0U7UUFBQSxRQUFBLEVBQVUsaUJBQVY7T0FERjtNQUVBLEtBQUEsRUFDRTtRQUFBLFFBQUEsRUFBVSxpQkFBVjtPQUhGO0tBZEY7O0FBREYiLCJmaWxlIjoiY29uZmlnL2Vudi90ZXN0LmpzIiwic291cmNlUm9vdCI6Ii9zb3VyY2UvIiwic291cmNlc0NvbnRlbnQiOlsibW9kdWxlLmV4cG9ydHMgPVxuICBlbnY6ICd0ZXN0J1xuXG4gIGdvb2RPcHRpb25zOlxuICAgIHJlc3BvbnNlUGF5bG9hZDogZmFsc2VcbiAgICByZXBvcnRlcnM6IFtcbiAgICAgICAgcmVwb3J0ZXI6IHJlcXVpcmUoJ2dvb2QtY29uc29sZScpXG4gICAgICAgIGV2ZW50czpcbiAgICAgICAgICByZXF1ZXN0OiAnZXJyb3InXG4gICAgICAgICAgbG9nOiAnKidcbiAgICAgICAgICByZXNwb25zZTogJ2Vycm9yJ1xuICAgICAgICAgIGVycm9yOiAnKidcbiAgICBdXG5cbiAgbW9uZ286XG4gICAgY29ubmVjdGlvbjpcbiAgICAgIGRhdGFiYXNlOiAnaW5zcGlyZS1tZS10ZXN0J1xuICAgIGxvZ0RCOlxuICAgICAgZGF0YWJhc2U6ICdpbnNwaXJlLW1lLXRlc3QnIl19
