(function() {
  module.exports = {
    constructMongoURI: function(username, password, hostname, port, database) {
      return "mongodb://" + username + ":" + password + "@" + hostname + ":" + port + "/" + database;
    }
  };

}).call(this);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImNvbXBvbmVudHMvdXRpbC9pbmRleC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7RUFBQSxNQUFNLENBQUMsT0FBUCxHQUNFO0lBQUEsaUJBQUEsRUFBbUIsU0FBQyxRQUFELEVBQVcsUUFBWCxFQUFxQixRQUFyQixFQUErQixJQUEvQixFQUFxQyxRQUFyQztBQUNqQixhQUFPLFlBQUEsR0FBYSxRQUFiLEdBQXNCLEdBQXRCLEdBQXlCLFFBQXpCLEdBQWtDLEdBQWxDLEdBQXFDLFFBQXJDLEdBQThDLEdBQTlDLEdBQWlELElBQWpELEdBQXNELEdBQXRELEdBQXlEO0lBRC9DLENBQW5COztBQURGIiwiZmlsZSI6ImNvbXBvbmVudHMvdXRpbC9pbmRleC5qcyIsInNvdXJjZVJvb3QiOiIvc291cmNlLyIsInNvdXJjZXNDb250ZW50IjpbIm1vZHVsZS5leHBvcnRzID1cbiAgY29uc3RydWN0TW9uZ29VUkk6ICh1c2VybmFtZSwgcGFzc3dvcmQsIGhvc3RuYW1lLCBwb3J0LCBkYXRhYmFzZSkgLT5cbiAgICByZXR1cm4gXCJtb25nb2RiOi8vI3t1c2VybmFtZX06I3twYXNzd29yZH1AI3tob3N0bmFtZX06I3twb3J0fS8je2RhdGFiYXNlfVwiIl19
