angular.module("app.services")
  .service "skrollrService", [
    "$document"
    "$q"
    "$rootScope"
    "$window"
    ($document, $q, $rootScope, $window) ->
      onScriptLoad = ->

        # Load client in the browser
        $rootScope.$apply ->
          s = $window.skrollr.init(forceHeight: false)
          defer.resolve s
          return

        return
      defer = $q.defer()

      # Create a script tag with skrollr as the source
      # and call our onScriptLoad callback when it
      # has been loaded
      scriptTag = $document[0].createElement("script")
      scriptTag.type = "text/javascript"
      scriptTag.async = true
      scriptTag.src = "bower_components/skrollr/dist/skrollr.min.js"
      scriptTag.onreadystatechange = ->
        onScriptLoad()  if @readyState is "complete"
        return

      scriptTag.onload = onScriptLoad
      s = $document[0].getElementsByTagName("body")[0]
      s.appendChild scriptTag
      return skrollr: ->
        defer.promise
  ]