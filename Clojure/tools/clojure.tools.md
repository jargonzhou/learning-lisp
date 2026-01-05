# Clojure Tools

# IDE
* [Editors](https://clojure.org/guides/editors)
* [Structural Editing](https://clojure.org/guides/structural_editing)

VS Code
* [Calva](./Calva.md): Calva is an integrated, REPL powered, development environment for enjoyable and productive Clojure and ClojureScript programming in Visual Studio Code. It is feature rich and turnkey. A lot of effort has been put into making Calva a good choice if you are new to Clojure. Calva is open source and free to use.

IDEA
* [Cursive](https://cursive-ide.com/index.html): The Clojure(Script) IDE that understands your code. Advanced structural editing, refactorings, VCS integration and much more, all out of the box.

# REPL
* https://clojure.org/guides/repl/introduction
* [clj-msi](https://github.com/casselc/clj-msi): This repo contains a script to build an MSI package for installing Clojure.
* [deps.clj](https://github.com/borkdude/deps.clj): A faithful port of the clojure CLI bash script to Clojure.
* [Try CLojure](https://tryclojure.org/): Clojure live REPL tutorial.
* [nREPL](https://github.com/nrepl/nrepl): A Clojure network REPL that provides a server and client, along with some common APIs of use to IDEs and other tools that may need to evaluate Clojure code in remote environments.

```shell
$ clj --version
Clojure CLI version (deps.clj) 1.12.3.1577
$ clojure --version
Clojure CLI version (deps.clj) 1.12.3.1577
```

# Project
* [boot](https://github.com/boot-clj/boot): Boot is a Clojure build framework and ad-hoc Clojure script evaluator.
* [clj-kondo](https://github.com/clj-kondo/clj-kondo): A static analyzer and linter for Clojure code that sparks joy. - `.clj-kondo/config.edn`
* [clj-new](https://github.com/seancorfield/clj-new): Generate new projects from Leiningen or Boot templates, or `clj-template` projects, using just the `clojure` command-line installation of Clojure!
* [Clojars](https://clojars.org/): Clojars is an easy to use community repository for open source Clojure libraries.
* [clojure-lsp](https://github.com/clojure-lsp/clojure-lsp): Clojure & ClojureScript Language Server (LSP) implementation. - `.lsp/config.edn`
* [deps-new](https://github.com/seancorfield/deps-new): Create new projects for the Clojure CLI / `deps.edn`.
* [Leiningen](./Leiningen/Leiningen.md): Leiningen is for automating Clojure projects without setting your hair on fire.
* [The Clojure Style Guide](https://guide.clojure.style/): This Clojure style guide recommends best practices so that real-world Clojure programmers can write code that can be maintained by other real-world Clojure programmers. A style guide that reflects real-world usage gets used, and a style guide that holds to an ideal that has been rejected by the people it is supposed to help risks not getting used at all — no matter how good it is.

# Documentation
* [cljdoc](https://cljdoc.org/): a website building & hosting documentation for Clojure/Script libraries.
* [Clojure Guides](https://clojure-doc.org/): the community-driven documentation site for the Clojure programming language.
* [ClojureDocs](https://clojuredocs.org/): a community-powered documentation and examples repository for the Clojure programming language.

# Testing
* [expectations](https://github.com/clojure-expectations/expectations): A minimalist's unit testing framework ("classic" version). - latest 2.1.10 2018-12-21.
* [test-runner](https://github.com/cognitect-labs/test-runner): test-runner is a small library for discovering and running tests in projects using native Clojure deps (i.e, those that use only Clojure's built-in dependency tooling, not Leiningen/boot/etc.).
* [kaocha](https://github.com/lambdaisland/kaocha): Full featured next generation test runner for Clojure. - 考察
  * example: [Getting Started with Clojure Unit Testing: A Simple Tutorial](https://tonitalksdev.com/how-to-get-started-with-tdd-in-clojure) - 2023-10-30

# Libraries
* [Cheshire](https://github.com/dakrone/cheshire): Cheshire is fast JSON encoding, based off of clj-json and clojure-json, with additional features like Date/UUID/Set/Symbol encoding and SMILE support.
* [Clojure.Java-Time](https://github.com/dm3/clojure.java-time): A Clojure wrapper for Java 8 Date-Time API.
* [Clostache](https://github.com/fhd/clostache): `{{ mustache }}` for Clojure.
* [Compojure](https://github.com/weavejester/compojure): Compojure is a small routing library for Ring that allows web applications to be composed of small, independent parts.
* [Component](https://github.com/stuartsierra/component): 'Component' is a tiny Clojure framework for managing the lifecycle and dependencies of software components which have runtime state. This is primarily a design pattern with a few helper functions. It can be seen as a style of dependency injection using immutable data structures.
* [core.async](https://github.com/clojure/core.async): A Clojure library providing facilities for async programming and communication.
* [core.logic](https://github.com/clojure/core.logic/): A logic programming library for Clojure & ClojureScript.
* [core.typed](https://github.com/clojure/core.typed): An optional type system for Clojure. deprecated as of Clojure 1.11.
* [google/clojure-turtle](https://github.com/google/clojure-turtle): A Clojure library that implements the Logo programming language in a Clojure context.
* [Hiccup](./ClojureScript/Hiccup.md): Fast library for rendering HTML in Clojure
* [http-kit](https://github.com/http-kit/http-kit): Simple, high-performance event-driven HTTP client+server for Clojure.
* [HugSQL](https://www.hugsql.org/): HugSQL is a Clojure library for embracing SQL.
* [Kit](https://kit-clj.github.io/): Kit is a lightweight, modular framework for scalable web development in Clojure. - a successor to Luminus 
  * https://github.com/kit-clj/kit
* [Korma](https://github.com/korma/Korma): Tasty SQL for Clojure.
* [Luminus](./Luminus.md): Luminus is a Clojure micro-framework based on a set of lightweight libraries. It aims to provide a robust, scalable, and easy to use platform.
* [markdown-clj](https://github.com/yogthos/markdown-clj): Markdown parser written in Clojure/Script.
* [Migratus](https://github.com/yogthos/migratus): A general migration framework, with implementations for migrations as SQL scripts or general Clojure code.
* [Pedestal](https://github.com/pedestal/pedestal): Pedestal is a set of libraries written in Clojure that aims to bring both the language and its principles (Simplicity, Power, and Focus) to server-side development.
* [Ring](./Ring.md): Ring is a Clojure web applications library inspired by Python's WSGI and Ruby's Rack. By abstracting the details of HTTP into a simple, unified API, Ring allows web applications to be constructed of modular components that can be shared among a variety of applications, web servers, and web frameworks.
* [Selmer](https://github.com/yogthos/Selmer): A fast, Django inspired template system in Clojure.
* [Sente](https://github.com/taoensso/sente): Realtime web comms library for Clojure/Script.
* [struct](https://github.com/funcool/struct): Structural validation library for Clojure(Script).

# ClojureScript
* [C2](https://github.com/lynaghk/c2): Declarative data visualization in Clojure(Script).
* [cljs-devtools](https://github.com/binaryage/cljs-devtools): adds enhancements into Chrome, Edge and Firefox DevTools for ClojureScript developers.
* [Domina](https://github.com/levand/domina): A DOM manipulation library for ClojureScript.
* [Enfocus](https://github.com/ckirkendall/enfocus): DOM manipulation and templating library for ClojureScript inspired by Enlive.
* [Figwheel Main](https://github.com/bhauman/figwheel-main): Figwheel Main provides tooling for developing ClojureScript applications.
* [jayq](https://github.com/ibdknox/jayq): A ClojureScript wrapper for jQuery.
* [lein-cljsbuild](https://github.com/emezeske/lein-cljsbuild): Leiningen plugin to make ClojureScript development easy.
* [lein-figwheel](https://github.com/bhauman/lein-figwheel): Figwheel builds your ClojureScript code and hot loads it into the browser as you are coding! - Figwheel Main is a complete re-write of Figwheel and represents the latest and greatest version of Figwheel.
* [mount](https://github.com/tolitius/mount): managing Clojure and ClojureScript app state since (reset).
* [Reagent](./ClojureScript/Reagent.md): A minimalistic ClojureScript interface to React.js.
* [re-frame](https://github.com/Day8/re-frame): A ClojureScript framework for building user interfaces, leveraging React.
* [re-frame-10x](https://github.com/Day8/re-frame-10x): A debugging dashboard for re-frame. X-ray vision as tooling.
* [re-frisk](https://github.com/flexsurfer/re-frisk): Take full control of re-frame application.
* [shadow-cljs](./ClojureScript/shadow-cljs.md): provides everything you need to compile your ClojureScript code with a focus on simplicity and ease of use.

# See Also
* [metosin/open-source](https://github.com/metosin/open-source): Home page for Metosin's open source development work.
  * compojure-api: Sweet web apis with Compojure & Swagger
  * jsonista: Clojure library for fast JSON encoding and decoding.
  * malli: High-performance data-driven data specification library for Clojure/Script.
  * muuntaja: Clojure library for fast http api format negotiation, encoding and decoding.
  * reagent-dev-tools: Development tool panel for Reagent
  * reitit: A fast data-driven routing library for Clojure/Script
  * ring-http-response: Handling HTTP Statuses with Clojure(Script)
  * ring-swagger: Swagger Spec for Clojure Web Apps
  * ring-swagger-ui: Swagger UI packaged for Ring Apps
  * schema-tools: Clojure(Script) tools for Plumatic Schema
  * spec-tools: Clojure(Script) tools for clojure.spec
  * ...
* [Useful Libraries - Luminus](Luminus.md#useful-libraries)
