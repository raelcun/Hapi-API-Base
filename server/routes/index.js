(function() {
  var fs, path;

  fs = require('fs');

  path = require('path');

  module.exports = function(server) {
    return fs.readdir(__dirname, function(err, files) {
      return files.forEach(function(e) {
        var basename, ext, i, len, ref, results, route;
        ext = path.extname(e).toLowerCase();
        basename = path.basename(e, ext).toLowerCase();
        if (ext !== '.coffee') {
          return;
        }
        if (basename === 'index') {
          return;
        }
        ref = require('./' + basename);
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          route = ref[i];
          results.push(server.route(route));
        }
        return results;
      });
    });
  };

}).call(this);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInJvdXRlcy9pbmRleC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUFBQSxNQUFBOztFQUFBLEVBQUEsR0FBSyxPQUFBLENBQVEsSUFBUjs7RUFDTCxJQUFBLEdBQU8sT0FBQSxDQUFRLE1BQVI7O0VBRVAsTUFBTSxDQUFDLE9BQVAsR0FBaUIsU0FBQyxNQUFEO1dBQ2YsRUFBRSxDQUFDLE9BQUgsQ0FBVyxTQUFYLEVBQXNCLFNBQUMsR0FBRCxFQUFNLEtBQU47YUFDcEIsS0FBSyxDQUFDLE9BQU4sQ0FBYyxTQUFDLENBQUQ7QUFDWixZQUFBO1FBQUEsR0FBQSxHQUFNLElBQUksQ0FBQyxPQUFMLENBQWEsQ0FBYixDQUFlLENBQUMsV0FBaEIsQ0FBQTtRQUNOLFFBQUEsR0FBVyxJQUFJLENBQUMsUUFBTCxDQUFjLENBQWQsRUFBaUIsR0FBakIsQ0FBcUIsQ0FBQyxXQUF0QixDQUFBO1FBQ1gsSUFBRyxHQUFBLEtBQVMsU0FBWjtBQUEyQixpQkFBM0I7O1FBQ0EsSUFBRyxRQUFBLEtBQVksT0FBZjtBQUE0QixpQkFBNUI7O0FBQ0E7QUFBQTthQUFBLHFDQUFBOzt1QkFBQSxNQUFNLENBQUMsS0FBUCxDQUFhLEtBQWI7QUFBQTs7TUFMWSxDQUFkO0lBRG9CLENBQXRCO0VBRGU7QUFIakIiLCJmaWxlIjoicm91dGVzL2luZGV4LmpzIiwic291cmNlUm9vdCI6Ii9zb3VyY2UvIiwic291cmNlc0NvbnRlbnQiOlsiZnMgPSByZXF1aXJlKCdmcycpXG5wYXRoID0gcmVxdWlyZSgncGF0aCcpXG5cbm1vZHVsZS5leHBvcnRzID0gKHNlcnZlcikgLT5cbiAgZnMucmVhZGRpciBfX2Rpcm5hbWUsIChlcnIsIGZpbGVzKSAtPlxuICAgIGZpbGVzLmZvckVhY2ggKGUpIC0+XG4gICAgICBleHQgPSBwYXRoLmV4dG5hbWUoZSkudG9Mb3dlckNhc2UoKVxuICAgICAgYmFzZW5hbWUgPSBwYXRoLmJhc2VuYW1lKGUsIGV4dCkudG9Mb3dlckNhc2UoKVxuICAgICAgaWYgZXh0IGlzbnQgJy5jb2ZmZWUnIHRoZW4gcmV0dXJuXG4gICAgICBpZiBiYXNlbmFtZSBpcyAnaW5kZXgnIHRoZW4gcmV0dXJuXG4gICAgICBzZXJ2ZXIucm91dGUocm91dGUpIGZvciByb3V0ZSBpbiByZXF1aXJlKCcuLycgKyBiYXNlbmFtZSkiXX0=
