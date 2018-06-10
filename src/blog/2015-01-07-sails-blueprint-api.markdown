---
layout: post
title: "Sails Blueprint API"
date: "2015-01-07 22:52:43 +0300"
comments: true
categories:
---

Blueprint API состоит из blueprint routes и blueprint actions, которые создают логику для [RESTful JSON API](https://ru.wikipedia.org/wiki/REST) каждый раз, когда создается модель и контроллер.

Например, если создать модель пользователя и соответствующий контроллер в проекте, то blueprint api позволит сразу создать пользователя /user/create?name=vanya и просмотреть массив созданных пользователей /user, не написав для этого ни одной строчки кода.

Blueprints удобно использовать при прототипирование, но и в продакшене тоже являются сильным инструментом так как могут быть расширены.

<!--more-->

### Blueprint Routes

Когда запускается приложение с помощью `sails lift` и blueprints включены, то фреймворк инспектирует ваши контроллеры, модели и конфигурации, чтобы назанчить необходимые роуты автоматически. Эти неявные роуты (иногда называемые "тени") позволяют приложению реагировать на те или иные запросы без необходимости привязки этих роутов вручную в сonfig/routes.js файле. По умолчанию "тени" указывают на соответствующие действий (см. "blueprint actions" ниже), любое из которых может быть переопределенно своим кодом.

Есть три вида blueprint роутов в Sails:

**RESTful routes**, когда роут всегда /:modelIdentity или /:modelIdentity/:id. Эти роуты использует HTTP методы POST, DELETE и так далее.

**Shortcut routes**, когда действие содержится в роуте. Например, /user/create?name=vanya создаст нового пользователя, в то время как user/update/1?name=pavel обновит запись для первого пользователя. Эти роуты отвечают только на GET запросы. Полезная фича для дева, но в продакшене лучше выключить.

**Action routes**, которые автоматически создаются для кастомных контроллеров. Например, есть контроллер FooController.js с bar методом, тогда роут /foo/bar будет автоматически создан, если blueprints включены. В отличие от остальных типов роутов эти не требуют, чтобы у контроллера была соответствующая модель.

[Подраздел конфигураций](http://sailsjs.org/#/documentation/reference/sails.config/sails.config.blueprints.html), в том числе, как включить/отключить различные роуты.

### Blueprint Actions

Blueprint actions (не путать с blueprint action routes) — это общие методы, направленные на работу с любым контроллером, который имеет модель с таким же именем. Можно думать о них, как о поведение по умолчанию для приложения. Например, если существует модель User.js и соответствующий контроллер UserController.js, то методы create, update, find, destroy, populate, add, remove будут доступны без необходимости писать их.

По умолчанию RESTful routes и shortcut routes привязаны к соответствующим общим методам. Тем не менее, любой такой метод может быть переопределен для конкретного контроллера путем создания этого метода в файле контроллера (FooController.find). Кроме того можно переопределить методы во всем приложение, создав кастомные методы (api/blueprints/create.js).

Текущая версия Sails поддерживает следующие методы:

1. [find](http://sailsjs.org/#/documentation/reference/blueprint-api/Find.html)
2. [findOne](http://sailsjs.org/#/documentation/reference/blueprint-api/FindOne.html)
3. [create](http://sailsjs.org/#/documentation/reference/blueprint-api/Create.html)
4. [update](http://sailsjs.org/#/documentation/reference/blueprint-api/Update.html)
5. [destroy](http://sailsjs.org/#/documentation/reference/blueprint-api/Destroy.html)
6. [populate](http://sailsjs.org/#/documentation/reference/blueprint-api/Populate.html)
7. [add](http://sailsjs.org/#/documentation/reference/blueprint-api/Add.html)
8. [remove](http://sailsjs.org/#/documentation/reference/blueprint-api/Remove.html)

Расмотренные методы blueprint API один в один, как методы выше.

### Переопределение blueprints

Чтобы переопределить blueprints в Sails v0.10 можно создать папку api/blueprints и добавить туда свои файлы (например, find.js, create.js и т.п). Можно посмотреть на код по умолчанию для начала.

**Важно**: Все файлы должны быть в нижнем регистре! По умолчанию действия, например, findOne.js, но в /api/blueprints должны быть findone.js.

Добавление пользовательских blueprint также поддерживаются, но они в настоящее время не получают автоматическую привязку к роутам. Если создаеть /blueprints/foo.js файл, то нужно связать роуты до него в /config/routes.js файле, например:

GET /myRoute': {blueprint: 'foo'}

Отключение blueprints контроллера:

Также можно переопределить любые настройки из config/blueprints.js для каждого контроллера путем осоздания объекта \_config в контроллере и присвоение ему конфигурации с переопределением настроек.

{% codeblock _config.js lang:js %}
module.exports = {
  _config: {
    actions: false,
    shortcuts: false,
    rest: false
  }
}
{% endcodeblock %}
