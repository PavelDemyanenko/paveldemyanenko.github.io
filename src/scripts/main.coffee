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
  #TODO: https://github.com/chieffancypants/angular-loading-bar/issues/153
  $rootScope.$on "cfpLoadingBar:completed", ->
    $('body').fadeIn("fast")
    return

  return

site.config [
  "cfpLoadingBarProvider"
  (cfpLoadingBarProvider) ->
    cfpLoadingBarProvider.latencyThreshold = 10000
]
