---
layout: post
title: "Приквел к Sails"
date: "2015-01-11 20:50:46 +0300"
comments: true
categories:
---

Sails спроектирован так, чтобы быть похожим на фреймворк Ruby on Rails, но направленный на нужды современных приложений: data-driven API с масштабируемой архитектурой. Этот фреймворк особенно хорош для чатов, игр и для всего того, что работает в режиме реального времени. Можно, конечно, использовать и для любых других типов веб приложений. Чтобы понять почему это всё может пригодиться,  надо понять как устроена экосистема node.js проектов.

<!--more-->

Примерная схема работы в Node.js включает в себя создание веб-сервера, роутера и контроллеров.
Важно понимать, что Node.js сам по себе не делает ничего «из коробки». Один из встроенных модулей позволяет без особых усилий создать простой HTTP-сервер. Другой, за работу с url и т.п. Ниже продемострирована такая схема создания проекта на Node.js.

{% codeblock server.js lang:js %}
var http = require("http");
var url = require("url");

function example(route, routes) {
  function onRequest(req, res) {
    var pathname = url.parse(req.url).pathname;
    console.log("Request for " + pathname + " recieved.");
    route(pathname, routes, res);
  }

  http.createServer(onRequest).listen(1337);
  console.log("Server running at http://127.0.0.1:1337/");
}

exports.example = example;
{% endcodeblock %}

{% codeblock router.js lang:js %}
function route(pathname, routes, res) {
  console.log("About to route a request for " + pathname)
  if (typeof routes[pathname] === "function") {
    routes[pathname](res);
  } else {
      console.log("No request found for " + pathname)
  }
}

exports.route = route;
{% endcodeblock %}

{% codeblock controller.js lang:js %}
function index(res) {
  console.log("Action index was called");
  res.writeHead(200, {
    "Content-type": "text/plain"
  });  

  var users = {
    user1: "Jack White",
    user2: "Jack Black",
    user3: "Jack Grey"
  };

  for (user in users) {
    console.log(users[user]);
    res.write(users[user] + "\n");
  }
  res.end();
}

function show(res) {
  console.log("Action show was called");

  res.writeHead(200, {
    "Content-type": "text/plain"
  });

  var users = {
    user1: "Jack White",
    user2: "Jack Black",
    user3: "Jack Grey"
  };

  res.write(users[user1]);
  res.end();
}

exports.index = index;
exports.show = show;
{% endcodeblock %}

{% gist e2cddca88214359c7933 router.js %}

И index.js, в котором будут подключены нужные файлы и сконфигурированы файлы.

{% codeblock index.js lang:js %}
var server = require("./server");
var router = require("./router");
var fooController = require("./fooController");

var routes = {};

routes["/index"] = fooController.index;
routes["/show"] = fooController.show;

server.example(router.route, routes);
{% endcodeblock %}

Как видно уже получается пачка кода, а ничего почти не сделано.

### Сколько времени уйдёт на создание мощного RESTful JSON API c Sails?

Ровно столько, сколько займут эти команды:


`$ sails new jsonapi`

`$ cd jsonapi`

`$ sails generate user`

Написано на основе SailsCasts.
