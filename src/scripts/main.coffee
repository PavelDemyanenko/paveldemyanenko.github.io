site = angular.module "app", [
  "angular-loading-bar",
  "ngAnimate",
  "ngRoute",
  "720kb.tooltips",
  "ngCountdownRibbon",
  "duScroll",
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

site.run ($rootScope, $timeout) ->
  angular.element(document).on "scroll", ->
    if angular.element(document).scrollTop() > 145
      angular.element(document).find("header").addClass "shrink"
    else if angular.element(document).scrollTop() < 145
      angular.element(document).find("header").removeClass "shrink"
    console.log 'Document scrolled to ', angular.element(document).scrollLeft(), angular.element(document).scrollTop()
  #TODO: https://github.com/chieffancypants/angular-loading-bar/issues/153
  $rootScope.$on "cfpLoadingBar:completed", (data, event) ->
    $timeout (->
      angular.element(document).find("body").css("display", "flex")
      return
    ), 1000
    return

  return

