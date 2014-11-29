app = angular.module("localFavoriteApp", [])

app.controller "BlacklistUserCtrl", ['$scope', '$http', ($scope, $http) ->
  $scope.users = []

  $scope.fetchBlacklist = ->
    $http.get("/blacklist_users").success( (data) ->
      $scope.users = data
    )

  $scope.addToBlacklist = ->
    return unless $scope.newUser && $scope.newUser.length > 0
    angular.forEach($scope.users, (user) ->
      return if user == $scope.newUser
    )

    $http.post("/blacklist_users"
      username: $scope.newUser
    ).success( (data) ->
      $scope.fetchBlacklist()
    )

  $scope.removeFromBlacklist = (username) ->
    $http.delete("/blacklist_users/" + username).success( (data) ->
      $scope.fetchBlacklist()
    )

  $scope.fetchBlacklist()
]