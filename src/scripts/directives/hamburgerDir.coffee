angular.module("app.directives")
  .directive("hamburgerMenu", [
    "$window"
    ($window) ->
      return (
        scope: {}
        restrict: "C"
        templateUrl: "scripts/directives/templates/hamburger-menu.html"
        link: ($scope, element, attrs) ->
          win = angular.element($window)
          menu = $scope.menu = element
          $scope.hide = ->
            menu.removeClass "open"
            return

          win.bind "resize.body", $scope.hide
          $scope.$on "$destroy", ->
            win.unbind "resize.body", $scope.hide
            return

          return

        controller: [
          "$scope"
          ($scope) ->
            @toggle = ->
              $scope.menu.toggleClass "open"

            @hide = ->
              $scope.hide()
            return
        ]
      )
  ]).directive("toggleHamburger", [->
    require: "^hamburgerMenu"
    restrict: "C"
    link: ($scope, element, attrs, hamburgerMenu) ->
      element.on "click", ->
        element.toggleClass "open"
        hamburgerMenu.toggle()
        return

      return
  ]).directive "hamburgerList", [->
    require: "^hamburgerMenu"
    restrict: "C"
    link: ($scope, element, attrs, hamburgerMenu) ->
      element.on "click", ->
        hamburgerMenu.hide()
        return

      return
  ]
