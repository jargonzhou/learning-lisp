# Luminus
* https://luminusweb.com/
* https://github.com/luminus-framework

> Luminus is a Clojure micro-framework based on a set of lightweight libraries. 
> It aims to provide a robust, scalable, and easy to use platform. 
> With Luminus you can focus on developing your app the way you want without any distractions.

# Your First Application

```shell
$ lein new luminus guestbook +h2 +immutant

$ tree guestbook
├── Capstanfile                                  // used to facilitate OSv deployments
├── Dockerfile                                   // used to facilitate Docker container deployments
├── Procfile                                     // used to facilitate Heroku deployments
├── README.md
├── env                                          // Environment specific code and resources
│   ├── dev
│   │   ├── clj
│   │   │   ├── guestbook
│   │   │   │   ├── dev_middleware.clj           // contains middleware used for development that should not be compiled in productions
│   │   │   │   └── env.clj                      // contains the development configuration defaults
│   │   │   └── user.clj                         // a utility namespace for any code you wish to run during REPL development
│   │   └── resources
│   │       ├── config.edn                       // default environment variables for the developments
│   │       └── logback.xml                      // used to configure the env logging profile
│   ├── prod
│   │   ├── clj
│   │   │   └── guestbook
│   │   │       └── env.clj
│   │   └── resources
│   │       ├── config.edn
│   │       └── logback.xml
│   └── test
│       └── resources
│           └── config.edn
│           └── logback.xml
├── dev-config.edn                               // used for local development configuration
├── test-config.edn                              // used for test development configuration
├── project.clj                                  // used to manage the project configuration and dependencies by Leiningen
├── resources                                    // where we put all the static resources for our applications
│   ├── docs                                     //
│   │   └── docs.md
│   ├── migrations                               // Luminus uses Migratus for migrations
│   │   ├── 20160811175305-add-users-table.down.sql
│   │   └── 20160811175305-add-users-table.up.sql
│   ├── public                                   // where we put all the static resources for our application
│   │   ├── css
│   │   │   └── screen.css
│   │   ├── favicon.ico
│   │   ├── img
│   │   └── js
│   ├── sql                                      // SQL queries
│   │   └── queries.sql                          //  defines the SQL queries and their associated function names
│   └── html                                     // for the Selmer templates that represent the application pages.
│       ├── about.html
│       ├── base.html
│       ├── error.html
│       └── home.html
├── src
│   └── clj
│       └── guestbook
│           ├── config.clj
│           ├── core.clj                         // the entry point for the application that contains the logic for starting and stopping the server
│           ├── db                               // used to define the model for the application and handle the persistence layer
│           │   └── core.clj                     //  used to house the functions for interacting with the database
│           ├── handler.clj                      // defines the base routes for the application, this is the entry point into the application 
│           ├── layout.clj                       // a namespace for the layout helpers used to render the content for our pages
│           ├── middleware
│           │   └── formats.clj
│           ├── middleware.clj
│           ├── nrepl.clj
│           └── routes                           // is where the routes and controllers for our home and about pages are located
│               └── home.clj                     //  a namespace that defines the home and about pages of the application
└── test                                         // where we put tests for our application,
    └── clj
        └── guestbook
            └── test
                ├── db
                │   └── core.clj
                └── handler.clj
```

`project.clj`
```clojure
(defproject guestbook "0.1.0-SNAPSHOT"

  :description "FIXME: write description"
  :url "http://example.com/FIXME"

  :dependencies [[cheshire "5.8.1"]                        ; Clojure JSON and JSON SMILE (binary json format) encoding/decoding
                 [clojure.java-time "0.3.2"]               ; A Clojure wrapper for Java 8 Date-Time API.
                 [com.h2database/h2 "1.4.197"]             ;
                 [conman "0.8.3"]                          ; a helper library for managing database connections
                 [cprop "0.1.13"]                          ; likes properties, environments, configs, profiles.. - https://github.com/tolitius/cprop
                 [funcool/struct "1.3.0"]                  ; Structural validation library for Clojure(Script)
                 [luminus-immutant "0.2.5"]                ; Immutant adapter for Luminus
                 [luminus-migrations "0.6.4"]              ; Migrations library for Luminus
                 [luminus-transit "0.1.1"]                 ; transit serialization helpers for Luminus
                 [luminus/ring-ttl-session "0.3.2"]        ; rovides an implementation of an in-memory ring SessionStore with TTL.
                 [markdown-clj "1.0.7"]                    ; Markdown parser written in Clojure/Script
                 [metosin/muuntaja "0.6.3"]                ; Clojure library for fast http api format negotiation, encoding and decoding.
                 [metosin/reitit "0.2.13"]                 ; A fast data-driven routing library for Clojure/Script
                 [metosin/ring-http-response "0.9.1"]      ; Handling HTTP Statuses with Clojure(Script)
                 [mount "0.1.16"]                          ; managing Clojure and ClojureScript app state since (reset).
                 [nrepl "0.6.0"]                           ; A Clojure network REPL that provides a server and client, along with some common APIs of use to IDEs and other tools that may need to evaluate Clojure code in remote environments.
                 [org.clojure/clojure "1.10.0"]            ;
                 [org.clojure/tools.cli "0.4.1"]           ;
                 [org.clojure/tools.logging "0.4.1"]       ;
                 [org.webjars.npm/bulma "0.7.4"]           ; https://www.webjars.org/
                 [org.webjars.npm/material-icons "0.3.0"]  ; https://www.webjars.org/
                 [org.webjars/webjars-locator "0.36"]      ; https://github.com/webjars/webjars-locator
                 [ring-webjars "0.2.0"]                    ; Ring middleware to serve static assets from WebJars.
                 [ring/ring-core "1.7.1"]                  ; core functions and middleware for Ring handlers, requests and responses
                 [ring/ring-defaults "0.3.2"]              ; A library to provide sensible Ring middleware defaults
                 [selmer "1.12.6"]]                        ; A fast, Django inspired template system in Clojure.

  :min-lein-version "2.0.0"

  :source-paths ["src/clj"]
  :test-paths ["test/clj"]
  :resource-paths ["resources"]
  :target-path "target/%s/"
  :main ^:skip-aot guestbook.core

  :plugins [[lein-immutant "2.1.0"]]

  :profiles
  {:uberjar {:omit-source true
             :aot :all
             :uberjar-name "guestbook.jar"
             :source-paths ["env/prod/clj"]
             :resource-paths ["env/prod/resources"]}

   :dev           [:project/dev :profiles/dev]
   :test          [:project/dev :project/test :profiles/test]

   :project/dev  {:jvm-opts ["-Dconf=dev-config.edn"]
                  :dependencies [[expound "0.7.2"]
                                 [pjstadig/humane-test-output "0.9.0"]
                                 [prone "1.6.1"]
                                 [ring/ring-devel "1.7.1"]
                                 [ring/ring-mock "0.3.2"]]
                  :plugins      [[com.jakemccrary/lein-test-refresh "0.23.0"]]

                  :source-paths ["env/dev/clj"]
                  :resource-paths ["env/dev/resources"]
                  :repl-options {:init-ns user}
                  :injections [(require 'pjstadig.humane-test-output)
                               (pjstadig.humane-test-output/activate!)]}
   :project/test {:jvm-opts ["-Dconf=test-config.edn"]
                  :resource-paths ["env/test/resources"]}
   :profiles/dev {}
   :profiles/test {}})
```

# REPL Driven Development
# Application Profiles

Routing
- `+reitit`: adds [Reitit](https://metosin.github.io/reitit/) Clojure/Script router support

web servers: Luminus defaults to using the [ring-undertow](https://github.com/luminus-framework/ring-undertow-adapter) webserver, however the following alternative servers are supported:
- `+jetty`: adds [Jetty](https://github.com/mpenet/jet) server support to the project
- `+aleph`: adds [Aleph](https://github.com/ztellman/aleph) server support to the project
- `+immutant`: add [Immutant](http://immutant.org/) support to the project
- `+http-kit`: adds the [HTTP Kit](https://github.com/http-kit/http-kit) web server to the project

databases
- `+h2`: adds `db.core` namespace and H2 db dependencies
- `+sqlite`: adds `db.core` namespace and SQLite db dependencies
- `+postgres`: adds `db.core` namespace and add PostreSQL dependencies
- `+mysql`: adds `db.core` namespace and add MySQL dependencies
- `+mongodb`: adds `db.core` namespace and MongoDB dependencies
- `+datomic`: adds `db.core` namespace and Datomic dependencies
- `+xtdb`: adds `db.core` namespace and XTDB dependencies

ClojureScript
- `+cljs`: adds [ClojureScript](http://clojurescript.org/) support
- +hoplon adds ClojureScript support with [Hoplon](https://github.com/hoplon/hoplon) to the project
- `+reagent`: adds ClojureScript support with [Reagent](https://reagent-project.github.io/)
- `+re-frame`: adds ClojureScript support with [re-frame](https://github.com/Day8/re-frame)
- `+kee-frame`: adds ClojureScript support with [kee-frame](https://github.com/ingesolvoll/kee-frame)
- `+shadow-cljs`: adds Clojurescript support with [shadow-cljs](https://github.com/thheller/shadow-cljs), replacing the default cljsbuild and figwheel setup

service API
- `+graphql`: adds GraphQL support using [Lacinia](https://github.com/walmartlabs/lacinia)
- `+swagger`: adds support for [Swagger-UI](https://github.com/swagger-api/swagger-ui)
- `+service`: create a service application without the front-end boilerplate such as HTML templates

miscellaneous
- `+boot`: uses [Boot](https://github.com/boot-clj/boot) as build tool and creates `build.boot` instead of `project.clj`
- `+auth`: adds [Buddy](https://github.com/funcool/buddy) dependency and authentication middleware
- `+auth-jwe`: adds [Buddy](https://github.com/funcool/buddy) dependency with the [JWE](https://jwcrypto.readthedocs.io/en/stable/jwe.html) backend
- `+oauth`: adds OAuth boilerplate for the [clj-oauth](https://github.com/mattrepl/clj-oauth) library
- `+cucumber`: a profile for cucumber with clj-webdriver
- `+sassc`: adds support for [SASS/SCSS](http://sass-lang.com/) files using [SassC](https://github.com/sass/sassc) command line compiler
- `+war`: adds support of building WAR archives for deployment to servers such as Apache Tomcat (should _NOT_ be used for [Immutant apps running on WildFly](https://luminusweb.com/docs/deployment.html#deploying_to_wildfly))
- `+site`: creates template for site using the specified database (H2 by default) and ClojureScript
- `+kibit`: adds [Kibit](https://github.com/jonase/kibit) static code analyzer support
- `+servlet`: adds middleware to support the servlet context for running inside Java application servers
- `+basic`: generates a bare bones luminus project

# HTML Templating
# Static Assets
# ClojureScript
# Routing
# RESTful Services
# Request types
# Response types
# Websockets
# Middleware
# Sessions and Cookies
# Input Validation
# Security
# Component Lifecycle
# Database Access
# Database Migrations
# Logging
# Internationalization
# Testing
# Server Tuning
# Environment Variables
# Deployment

# Useful Libraries

Luminus aims to provide solid defaults for creating your web application. As such it comes packaged with several libraries by default. These libraries include [Buddy](https://github.com/funcool/buddy) for security, [Bouncer](https://github.com/leonardoborges/bouncer) for validation, [Selmer](https://github.com/yogthos/Selmer) for HTML templating, [Tower](https://github.com/ptaoussanis/tower) for internationalization and a few others. Of course, there are many other Clojure libraires for web development. Here we are going to provide a list of Clojure and ClojureScript libraries which can be useful in addition to those already included with Luminus.

Assets/资产
- [Stefon](https://github.com/circleci/stefon) - asset pipeline ring middleware
- [lein-asset-minifier](https://github.com/yogthos/lein-asset-minifier) - a Leiningen plugin to minify CSS and Js assets

Authentication/身份验证
- [Friend](https://github.com/cemerick/friend) - an extensible authentication and authorization library
- [clj-ldap](https://github.com/pauldorman/clj-ldap) - a library for talking to LDAP servers
- [ring-basic-authentication](https://github.com/remvee/ring-basic-authentication) - Ring middleware to enforce basic authentication
- [ring-oauth2](https://github.com/weavejester/ring-oauth2) - Ring middleware that acts as a OAuth 2.0 client

Caching/缓存
- [Spyglass](https://github.com/clojurewerkz/spyglass) - a Memcached client (also: Couchbase, Kestrel)
- [core.cache](https://github.com/clojure/core.cache) - a caching library implementing various cache strategies

Configuration/配置
- [lein-init-script](https://github.com/strongh/lein-init-script) - a plugin for *nix init script generation

ClojureScript
- [Om](https://github.com/swannodette/om) - ClojureScript interface to Facebook's React
- [Kioo](https://github.com/ckirkendall/kioo) - DOM manipulation and templating library for Reagent/Om
- [Hickory](https://github.com/davidsantiago/hickory) - parses HTML into Clojure data structures
- [Sente](https://github.com/ptaoussanis/sente) - bidirectional a/sync comms over both WebSockets and Ajax (auto-fallback)
- [Datascript](https://github.com/tonsky/datascript) - central, uniform approach to manage all application state
- [Garden](https://github.com/noprompt/garden) - a library for rendering CSS in Clojure and ClojureScript
- [Dommy](https://github.com/Prismatic/dommy) - a no-nonsense templating and (soon) dom manipulation library
- [json-html](https://github.com/yogthos/json-html) - generates human representation of the JSON/EDN encoded data
- [lein-externs](https://github.com/ejlo/lein-externs) - a plugin to automatically generate externs files for Js libs

Database clients/数据库客户端
- [Carmine](https://github.com/ptaoussanis/carmine) - Clojure Redis client & message queue
- [Cassaforte](https://github.com/clojurewerkz/cassaforte) - A young client for Apache Cassandra 1.2+
- [Clutch](https://github.com/clojure-clutch/clutch) - a library for Apache CouchDB
- [CongoMongo](https://github.com/aboekhoff/congomongo) - Wrapper for the mongo-db java api
- [Monger](http://clojuremongodb.info/) - a client for MongoDB
- [Neocons](https://github.com/michaelklishin/neocons) - a feature rich idiomatic client for the Neo4J REST API
- [pgjdbc-ng](http://impossibl.github.io/pgjdbc-ng/) - JDBC driver with PostgreSQL specific features
- [Rotary](https://github.com/weavejester/rotary) - DynamoDB API
- [Rummage](https://github.com/cemerick/rummage) - a client library for Amazon's SimpleDB (SDB)
- [Welle](http://clojureriak.info/) - an expressive client for Riak

Database Migrations/数据库迁移
- [Drift](https://github.com/macourtney/drift) - a migration library
- [Ragtime](https://github.com/weavejester/ragtime) - database-independent migration library

SQL Libraries/SQL库
- [Honey SQL](https://github.com/jkk/honeysql) - a Korma alternative DSL for building SQL queries
- [clojure.java.jdbc](https://github.com/clojure/java.jdbc) - a low level wrapper for Java JDBC
- [blackwater](https://github.com/bitemyapp/blackwater) - a library for logging SQL queries and the time they took for Korma and clojure.java.jdbc
- [walkable](https://github.com/walkable-server/walkable) - Datomic pull syntax for building SQL queries

Dependency Injection/依赖注入
- [mount](https://github.com/tolitius/mount)
- [yoyo](https://github.com/jarohen/yoyo)

Email/邮件
- [Mailer](https://github.com/clojurewerkz/mailer) - an ActionMailer-inspired mailer library
- [Postal](https://github.com/drewr/postal) - Clojure email support

Graphics/图形
- [Analemma](http://liebke.github.com/analemma/) - a Clojure-based SVG DSL and charting library
- [Monet](https://github.com/rm-hull/monet) - a small ClojureScript library to make it easier (and performant) to work with canvas

Template Languages/模板语言
- [Cuma](https://github.com/liquidz/cuma) - extensible micro template engine for Clojure.
- [Basil](https://github.com/kumarshantanu/basil) - a general purpose template library
- [Stencil](https://github.com/davidsantiago/stencil) - a fast, compliant implementation of Mustache
- [Enlive](https://github.com/cgrand/enlive) - a selector-based (à la CSS) templating and transformation system

Miscellaneous/杂项
- [clj-pdf](https://github.com/yogthos/clj-pdf) - PDF report generation library
- [clj-rss](https://github.com/yogthos/clj-rss) - a library for generating RSS feeds
- [metrics-clojure](https://github.com/sjl/metrics-clojure/) - a thin Clojure façade around Coda Hale’s wonderful metrics library
- [ring-logger-timbre](https://github.com/nberger/ring-logger-timbre) - log Ring requests & responses using Timbre
- [slf4j-timbre](https://github.com/fzakaria/slf4j-timbre) - SLF4J binding for Clojure's Timbre logging library
- [ring-cors](https://github.com/r0man/ring-cors) CORS middleware for Ring
- [ring-rewrite](https://github.com/ebaxt/ring-rewrite) - Ring middleware for defining and applying rewrite rules
- [Pantomime](https://github.com/michaelklishin/pantomime) - a Library For Working With MIME Types
- [Route One](https://github.com/clojurewerkz/route-one) - a library that generates HTTP resource routes (as in Ruby on Rails and similar modern Web application frameworks)
- [Schema](https://github.com/prismatic/schema) - a Clojure(Script) library for declarative data description and validation.
- [Urly](https://github.com/michaelklishin/urly) - a library that unifies parsing of URIs, URLs and URL-like values like relative href values
- [Validateur](http://clojurevalidations.info/articles/getting_started.html) - a validation library inspired by Ruby's ActiveModel
- [aging-session](https://github.com/diligenceengine/aging-session) - a memory based ring session store that has a concept of time
- [Timbre](https://github.com/ptaoussanis/timbre) - a Clojure/Script logging and profiling library
- [Throttler](https://github.com/brunoV/throttler) - token bucket algorithm to control both the overall rate as well as the burst rate for function calls (e.g. incoming requests)
- [Elastisch](https://github.com/clojurewerkz/elastisch) - a minimalistic Clojure client for ElasticSearch, a modern distributed search engine
- [cronj](https://github.com/zcaudate-me/cronj) - a library for scheduling tasks
- [ring-async](https://github.com/ninjudd/ring-async) - a Ring adapter for supporting asynchronous responses
- [lein-nvd](https://github.com/rm-hull/lein-nvd) - National Vulnerability Database dependency-checker plugin for Leiningen
    
Web Services/Web服务
- [sweet-liberty](https://github.com/RJMetrics/sweet-liberty) - a library for building database-backed RESTful services
- [Liberator](http://clojure-liberator.github.com/) - a library for creating REST services
- [necessary-evil](https://github.com/brehaut/necessary-evil) - XML RPC library for Clojure
- [lacinia](https://github.com/walmartlabs/lacinia) - a GraphQL implementation for Clojure

## See Also

It's just few categories, more libraries related to web development for testing, data validation, text search, random data generation, JSON parsing, exception handling, SQL abstractions and other can be found on The Clojure Toolbox and ClojureWerkz websites.
* [ClojureWerkz](https://github.com/clojurewerkz): A growing collection of open source Clojure libraries.
* [The Clojure Toolbox](https://www.clojure-toolbox.com/): A categorised directory of libraries and tools for Clojure.

# Sample Applications
# Upgrading
# Clojure Resources

Clojure Books
* Living Clojure
* Clojure Cookbook
* Clojure Programming
* Clojure in Action
* The Joy of Clojure: Thinking the Clojure Way
* Practical Clojure
* Web Development with Clojure
* Clojure Web Development Essentials

# See Also
* [luminus-template](https://github.com/luminus-framework/luminus-template): a template project for the Luminus framework.