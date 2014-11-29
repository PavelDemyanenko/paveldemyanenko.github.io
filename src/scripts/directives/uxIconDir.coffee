angular.module("app.directives")
  .directive("uxIcon", [ ->
      return (
        scope: {}
        restrict: "C"
        templateUrl: "scripts/directives/templates/ux-icon.html"
        link: ($scope, element, attrs) ->
          uxIcon = $scope.uxIcon = element
          $scope.newGradient = ->
            c1 =
              r: Math.floor(Math.random() * 255)
              g: Math.floor(Math.random() * 255)
              b: Math.floor(Math.random() * 255)

            c2 =
              r: Math.floor(Math.random() * 255)
              g: Math.floor(Math.random() * 255)
              b: Math.floor(Math.random() * 255)

            c1.rgb = "rgb(" + c1.r + "," + c1.g + "," + c1.b + ")"
            c2.rgb = "rgb(" + c2.r + "," + c2.g + "," + c2.b + ")"
            return "radial-gradient(at top left, " + c1.rgb + ", " + c2.rgb + ")"

          $scope.rollBg = ->
            $(uxIcon).find(".hidden").css "background", $scope.newGradient()
            $(uxIcon).find(".ux").toggleClass "hidden"

            return

          angular.element(document).ready ->
            $scope.rollBg()
            setInterval $scope.rollBg, 5000

            return

      )
  ])
