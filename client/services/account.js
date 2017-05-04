angular.module('MyApp')
  .factory('Account', function($http) {
    return {
      getProfile: function() {
        return $http.get('https://musiciogrupo2.herokuapp.com/users/me');
      },
      updateProfile: function(profileData) {
		console.log(profileData);		
		profileData.image = "data:image/jpeg;base64," + profileData.image ;
		//return $http.put('https://musiciogrupo2.herokuapp.com/users/'+ profileData.UserID.toString(), profileData);
      }
    };
  });
