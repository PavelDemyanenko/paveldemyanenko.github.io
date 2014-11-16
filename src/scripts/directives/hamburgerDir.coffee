angular.module("app.directives")
  .directive("hamburgerMenu", [
    "$window"
    ($window) ->
      return (
        scope: {}
        restrict: "C"
        link: ($scope, element, attrs) ->
          win = angular.element($window)
          sidebar = $scope.sidebar = element
          $scope.hide = ->
            sidebar.removeClass "open"
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
              $scope.sidebar.toggleClass "open"

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