---
layout: post
title: "Настройка базы данных в Sails"
date: "2015-01-09 17:50:10 +0300"
comments: true
categories:
---

В Sails приложениях адаптеры выступают посредниками между приложением и базой данных. Конкретнее, как плагины для [Waterline](https://github.com/balderdashy/waterline), [ORM](https://ru.wikipedia.org/wiki/ORM) для работы с базой данных. Настройка этих адаптеров происходит в файле config/connections.js

<!--more-->

Файл connection.js позволяет создавать разные глобальные настройки, которые можно подмиксовывоть в модели. Опция по умолчанаю будет автоматически подмиксовываться в модель, если в ней не указан адаптер. Важно помнить, что когда указывается адаптер в моделе, то перезаписывается настройка по умолчанию.

Важно отметить, что если используются секретные данные (passwords, API keys), то их нужно назначать в файле config/local.js, он добвлен в .gitignore по умолчанию.

{% codeblock local_example.js lang:js %}
module.exports = {
  connections: {
    mysql: {
      adapter: 'sails-mysql',
      host: 'localhost',
      user: 'tutorialuser',
      password: '',
      database: 'tutorialdb',
      charset: 'utf8'
    }
  },

  models: {
    connection: 'mysql'
  },

  session: {
    secret: ''
  },

  port: 1337,

  environment: 'development',

  log: {
    level: 'info'
  }

};

{% endcodeblock %}

{% codeblock connection.js lang:js http://sailsjs.org/#/documentation/anatomy/myApp/config/connections.js.html Sails Documentation %}
/**
* Connections
* (sails.config.connections)
*
* `Connections` are like "saved settings" for your adapters.  What's the difference between
* a connection and an adapter, you might ask?  An adapter (e.g. `sails-mysql`) is generic--
* it needs some additional information to work (e.g. your database host, password, user, etc.)
* A `connection` is that additional information.
*
* Each model must have a `connection` property (a string) which is references the name of one
* of these connections.  If it doesn't, the default `connection` configured in `config/models.js`
* will be applied.  Of course, a connection can (and usually is) shared by multiple models.
* .
* Note: If you're using version control, you should put your passwords/api keys
* in `config/local.js`, environment variables, or use another strategy.
* (this is to prevent you inadvertently sensitive credentials up to your repository.)
*
* For more information on configuration, check out:
* http://links.sailsjs.org/docs/config/connections
*/
module.exports.connections = {

  // Local disk storage for DEVELOPMENT ONLY
  //
  // Installed by default.
  //
  localDiskDb: {
    adapter: 'sails-disk'
  },

  // MySQL is the world's most popular relational database.
  // http://en.wikipedia.org/wiki/MySQL
  //
  // Run:
  // npm install sails-mysql
  //
  someMysqlServer: {
    adapter: 'sails-mysql',
    host: 'YOUR_MYSQL_SERVER_HOSTNAME_OR_IP_ADDRESS',
    user: 'YOUR_MYSQL_USER',
    password: 'YOUR_MYSQL_PASSWORD',
    database: 'YOUR_MYSQL_DB'
  },

  // MongoDB is the leading NoSQL database.
  // http://en.wikipedia.org/wiki/MongoDB
  //
  // Run:
  // npm install sails-mongo
  //
  someMongodbServer: {
    adapter: 'sails-mongo',
    host: 'localhost',
    port: 27017,
    // user: 'username',
    // password: 'password',
    // database: 'your_mongo_db_name_here'
  },

  // PostgreSQL is another officially supported relational database.
  // http://en.wikipedia.org/wiki/PostgreSQL
  //
  // Run:
  // npm install sails-postgresql
  //
  somePostgresqlServer: {
    adapter: 'sails-postgresql',
    host: 'YOUR_POSTGRES_SERVER_HOSTNAME_OR_IP_ADDRESS',
    user: 'YOUR_POSTGRES_USER',
    password: 'YOUR_POSTGRES_PASSWORD',
    database: 'YOUR_POSTGRES_DB'
  }

  // More adapters:
  // https://github.com/balderdashy/sails

};
{% endcodeblock %}

{% codeblock local.js lang:js http://sailsjs.org/#/documentation/anatomy/myApp/config/local.js.html Sails Documentation %}
/**
* Local environment settings
*
* While you're DEVELOPING your app, this config file should include
* any settings specifically for your development computer (db passwords, etc.)
*
* When you're ready to deploy your app in PRODUCTION, you can always use this file
* for configuration options specific to the server where the app will be deployed.
* But environment variables are usually the best way to handle production settings.
*
* PLEASE NOTE:
*        This file is included in your .gitignore, so if you're using git
*        as a version control solution for your Sails app, keep in mind that
*        this file won't be committed to your repository!
*
*        Good news is, that means you can specify configuration for your local
*        machine in this file without inadvertently committing personal information
*        (like database passwords) to the repo.  Plus, this prevents other members
*        of your team from commiting their local configuration changes on top of yours.
*
*
* For more information, check out:
* http://links.sailsjs.org/docs/config/local
*/

module.exports = {

  // Your SSL certificate and key, if you want to be able to serve HTTP responses
  // over https:// and/or use websockets over the wss:// protocol
  // (recommended for HTTP, strongly encouraged for WebSockets)
  //
  // In this example, we'll assume you created a folder in your project, `config/ssl`
  // and dumped your certificate/key files there:
  // ssl: {
  //   ca: require('fs').readFileSync(__dirname + './ssl/my_apps_ssl_gd_bundle.crt'),
  //   key: require('fs').readFileSync(__dirname + './ssl/my_apps_ssl.key'),
  //   cert: require('fs').readFileSync(__dirname + './ssl/my_apps_ssl.crt')
  // },


  // The `port` setting determines which TCP port your app will be deployed on
  // Ports are a transport-layer concept designed to allow many different
  // networking applications run at the same time on a single computer.
  // More about ports: http://en.wikipedia.org/wiki/Port_(computer_networking)
  //
  // By default, if it's set, Sails uses the `PORT` environment variable.
  // Otherwise it falls back to port 1337.
  //
  // In production, you'll probably want to change this setting
  // to 80 (http://) or 443 (https://) if you have an SSL certificate

  port: process.env.PORT || 1337,

  // The runtime "environment" of your Sails app is either 'development' or 'production'.
  //
  // In development, your Sails app will go out of its way to help you
  // (for instance you will receive more descriptive error and debugging output)
  //
  // In production, Sails configures itself (and its dependencies) to optimize performance.
  // You should always put your app in production mode before you deploy it to a server-
  // This helps ensure that your Sails app remains stable, performant, and scalable.
  //
  // By default, Sails sets its environment using the `NODE_ENV` environment variable.
  // If NODE_ENV is not set, Sails will run in the 'development' environment.

  environment: process.env.NODE_ENV || 'development'

};
{% endcodeblock %}
