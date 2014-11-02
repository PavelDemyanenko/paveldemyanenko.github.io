angular.module("app.home")
  .controller "homeCtrl", ($scope) ->
    $scope.pageClass = "page-home";
    $scope.message = "home"
    return
