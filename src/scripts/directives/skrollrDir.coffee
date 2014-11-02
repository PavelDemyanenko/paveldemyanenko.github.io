angular.module("app.directives")
  .directive "skrollrTag", [
    "skrollrService"
    (skrollrService) ->
      return link: ($scope, element, attrs) ->
        skrollrService.skrollr().then (skrollr) ->
          skrollr.refresh()
          return

        # This will watch for any new elements being added
        # as children to whatever element this directive is placed on.
        # If new elements are added, skrollr will be
        # refreshed pulling in the new elements
        $scope.$watch (->
          element[0].childNodes.length
        ), (newValue, oldValue) ->
          if newValue isnt oldValue
            skrollrService.skrollr().then (skrollr) ->
              skrollr.refresh()
              return

          return

        return
  ]