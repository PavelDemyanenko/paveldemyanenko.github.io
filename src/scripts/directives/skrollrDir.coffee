angular.module("app.directives")
  .directive "skrollrTag", [
    "skrollrService"
    (skrollrService) ->
      return link: ->
        skrollrService.skrollr().then (skrollr) ->
          skrollr.refresh()
          return

        return
  ]