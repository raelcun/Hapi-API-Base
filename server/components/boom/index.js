(function() {
  var Boom, oldCreate;

  Boom = require('boom');

  oldCreate = Boom.create;

  Boom.create = function() {
    var oldRet;
    oldRet = oldCreate.apply(this, arguments);
    if (oldRet.data != null) {
      oldRet.output.payload.details = oldRet.data;
    }
    return oldRet;
  };

  module.exports = Boom;

}).call(this);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImNvbXBvbmVudHMvYm9vbS9pbmRleC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUFBQSxNQUFBOztFQUFBLElBQUEsR0FBTyxPQUFBLENBQVEsTUFBUjs7RUFFUCxTQUFBLEdBQVksSUFBSSxDQUFDOztFQUNqQixJQUFJLENBQUMsTUFBTCxHQUFjLFNBQUE7QUFDWixRQUFBO0lBQUEsTUFBQSxHQUFTLFNBQVMsQ0FBQyxLQUFWLENBQWdCLElBQWhCLEVBQXNCLFNBQXRCO0lBQ1QsSUFBRyxtQkFBSDtNQUFxQixNQUFNLENBQUMsTUFBTSxDQUFDLE9BQU8sQ0FBQyxPQUF0QixHQUFnQyxNQUFNLENBQUMsS0FBNUQ7O0FBQ0EsV0FBTztFQUhLOztFQUtkLE1BQU0sQ0FBQyxPQUFQLEdBQWlCO0FBUmpCIiwiZmlsZSI6ImNvbXBvbmVudHMvYm9vbS9pbmRleC5qcyIsInNvdXJjZVJvb3QiOiIvc291cmNlLyIsInNvdXJjZXNDb250ZW50IjpbIkJvb20gPSByZXF1aXJlKCdib29tJylcblxub2xkQ3JlYXRlID0gQm9vbS5jcmVhdGVcbkJvb20uY3JlYXRlID0gLT5cbiAgb2xkUmV0ID0gb2xkQ3JlYXRlLmFwcGx5KHRoaXMsIGFyZ3VtZW50cylcbiAgaWYgb2xkUmV0LmRhdGE/IHRoZW4gb2xkUmV0Lm91dHB1dC5wYXlsb2FkLmRldGFpbHMgPSBvbGRSZXQuZGF0YVxuICByZXR1cm4gb2xkUmV0XG5cbm1vZHVsZS5leHBvcnRzID0gQm9vbSJdfQ==
