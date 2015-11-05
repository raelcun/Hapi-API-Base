(function() {
  var LoginCtrl;

  LoginCtrl = require('../controllers/login');

  module.exports = [
    {
      method: 'POST',
      path: '/login',
      handler: LoginCtrl.login,
      config: {
        auth: false
      }
    }
  ];

}).call(this);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInJvdXRlcy9sb2dpbi5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUFBQSxNQUFBOztFQUFBLFNBQUEsR0FBWSxPQUFBLENBQVEsc0JBQVI7O0VBRVosTUFBTSxDQUFDLE9BQVAsR0FBaUI7SUFDZjtNQUNFLE1BQUEsRUFBUSxNQURWO01BRUUsSUFBQSxFQUFNLFFBRlI7TUFHRSxPQUFBLEVBQVMsU0FBUyxDQUFDLEtBSHJCO01BSUUsTUFBQSxFQUFRO1FBQUEsSUFBQSxFQUFNLEtBQU47T0FKVjtLQURlOztBQUZqQiIsImZpbGUiOiJyb3V0ZXMvbG9naW4uanMiLCJzb3VyY2VSb290IjoiL3NvdXJjZS8iLCJzb3VyY2VzQ29udGVudCI6WyJMb2dpbkN0cmwgPSByZXF1aXJlKCcuLi9jb250cm9sbGVycy9sb2dpbicpXG5cbm1vZHVsZS5leHBvcnRzID0gW1xuICB7XG4gICAgbWV0aG9kOiAnUE9TVCdcbiAgICBwYXRoOiAnL2xvZ2luJ1xuICAgIGhhbmRsZXI6IExvZ2luQ3RybC5sb2dpblxuICAgIGNvbmZpZzogYXV0aDogZmFsc2VcbiAgfVxuXSJdfQ==
