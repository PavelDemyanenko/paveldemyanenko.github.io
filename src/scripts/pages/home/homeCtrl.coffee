angular.module("app.home")
  .controller "homeCtrl", ($scope) ->
    $scope.pageClass = "page-home"

    #temp
    $scope.changeClass = (event)->
      $(event.currentTarget).parentsUntil('figure').parent(".job-item").toggleClass "active"
      return false

    return

