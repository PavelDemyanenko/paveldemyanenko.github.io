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
          toggle = $scope.toggle = menu.children(".hamburger-toggle")
          $scope.hide = ->
            menu.removeClass "open"
            toggle.removeClass "open"
            angular.element(document).find("header").removeClass "static"
            angular.element(document).find(".page").removeClass "static"
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
  ]).directive("hamburgerToggle", [->
    require: "^hamburgerMenu"
    restrict: "C"
    link: ($scope, element, attrs, hamburgerMenu) ->
      element.on "click", ->
        angular.element(document).find("header").toggleClass("static")
        angular.element(document.querySelector('.page')).toggleClass("static")
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
