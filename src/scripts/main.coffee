site = angular.module "app", [
  "angular-loading-bar",
  "ngAnimate",
  "ngRoute",
  "ngCountdownRibbon",
  require("./services").name,
  require("./directives").name,
  require("./pages/home").name,
  require("./pages/about").name,
  require("./pages/contact").name
]

site.config ($routeProvider) ->

  $routeProvider.when("/",
    templateUrl: "pages/home.html"
    controller: "homeCtrl"
  ).when("/about",
    templateUrl: "pages/about.html"
    controller: "aboutCtrl"
  ).when "/contact",
    templateUrl: "pages/contact.html"
    controller: "contactCtrl"

  return

site.run ($rootScope) ->
  $rootScope.$on "cfpLoadingBar:loading", (event, data) ->
    console.log "loading", data
    return
  $rootScope.$on "cfpLoadingBar:completed", ->
    console.log "loaded"
    return

  return
