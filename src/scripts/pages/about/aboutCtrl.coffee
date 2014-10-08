angular.module("app.about")
  .controller "aboutCtrl", ($scope) ->
    $scope.pageClass = 'page-about';
    $scope.message = "about"
    return
