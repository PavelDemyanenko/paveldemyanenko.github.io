angular.module("app.contact")
  .controller "contactCtrl", ($scope) ->
    $scope.pageClass = 'page-contact';
    $scope.message = "contact"
    return
