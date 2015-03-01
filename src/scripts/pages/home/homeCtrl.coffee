angular.module("app.home")
  .controller "homeCtrl", ($scope, ngCountdownRibbon) ->
    $scope.pageClass = "page-home"
    ngCountdownRibbon.set('2015-03-26', 'http://amzn.com/w/ZWFNUL8AGNLP');

    $scope.changeClass = (event)->
      angular.element(event.currentTarget).parent().parent().toggleClass "active"
      return false

    return
