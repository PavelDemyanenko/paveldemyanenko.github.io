angular.module("app.contact")
  .controller "contactCtrl", ($scope) ->
    console.log $scope
    $scope.pageClass = "page-contact"
    $scope.message = "contact"
    return
