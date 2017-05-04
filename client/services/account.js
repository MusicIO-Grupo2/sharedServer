angular.module('MyApp')
  .factory('Account', function($http) {
    return {
      getProfile: function() {
	console.log("OK Entro");
        return $http.get('https://musiciogrupo2.herokuapp.com/users/me');
      },
      updateProfile: function(profileData) {
        return $http.put('/api/me', profileData);
      }
    };
  });
