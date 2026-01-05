# Web Development with Clojure, 3rd Edition
* https://pragprog.com/titles/dswdcloj3/web-development-with-clojure-third-edition/

# Introduction
- What You Need
- Why Clojure?
- Why Make Web Apps in Clojure?

# 1. Getting Your Feet Wet
- Set Up Your Environment
- Managing Projects with Leiningen
- Build Your First Web App
  - creating an application from the Luminus template: `+h2` `+http-kit`, version 3.91
  - what's in a web app
    - mount
    - env/dev/clj/user.clj
- Refine Your App
  - managing database migrations: luminus-migrations
  - querying the database: HugSQL, conman
  - creating tests: clojure.test
  - defining HTTP routes: Bulma CSS
  - validating input: struct
  - running standalone: `lein uberjar`

# 2. Luminus Web Stack
- Route Requests with Ring/处理请求响应
  - creating a web server
  - handling requests
    - `ring.adapter.jetty`
    - `ring.util.response`
  - request and response maps
  - adding functionality with middleware: `wrap-reload`
  - what are the adapters
- Extend Ring
  - ring-defaults: API middleware, site middleware
    - configuration: [secure-]api-defaults, [secure-]site-defaults
  - `ring-http-response`: map to HTTP codes
  - `muuntaja`: encoding formats, JSON, YAML, END, transit
- Define the Routes with Reitit/路由: `reitit/ring-handler`, `reitit/router`
  - Reitit defaults: `reitit/create-default-handler`, `reitit/create-resource-handler`, `reitit/routes`
- HTML Templating Using Selmer/HTML模板
  - `selmer/render`, `selmer/render-file`, `selmer.parser/set-resource-path!`
  - memoized by default: `selmer.parser/cache-on!`, `selmer.parser/cache-off!`
  - using filters: ex `{{name|upper}}`
    - `filters/add-filter!`
  - using template tags
    - inline tags: 
      - extending templates: `extends`, `{{block.super}}`
      - including templates: `include`
    - block tags: ex `if ... endif`
  - defining custom tags
    - `selmer/add-tag!` 
  - error handling: `selmer.middleware/wrap-error-page` 

# 3. Luminus Architecture
- Manage the Project
  - Leiningen `project.clj` profiles: `dev`, `test`, `uberjar`
  - profile-specific resources
  - running code selectively: dev/prod `env.clj`
- Think in Terms of Application Components
  - application core: `core`
  - application configuration: `config`, `config.edn`, `[dev|test]-config.edn`
    - `cprop`: `-Dconf` JVM environment
  - application handler: `handler`
    - `ring/router`: aggretate routes for handling all the requests to our application
    - `ring/routes`: default ring handler serving resource/webjars/error pages
    - `ring/ring-handler`: create the top ring handler
  - application middleware: `middleware`
    - wrapper functions to modify requests and responses
    - `wrape-csrf`. `wrap-base`
  - routing requests: `routes`
    - a map defines handler function for request methods, and route-specific configuration
  - application model: `db`
    - query results are represented by sequences of maps
    - `*db*`: database connection
  - application layout: `layout`
    - provide visual layout and common elements for pages
  - defining pages
    - Hiccup, Selmer
    - service-side templates, SPA(single-page application)
- Managing Stateful Components
  - resources have a file cycle associated with them
  - Mount: treat resources as variables bound to namespaces

# 4. Introducing ClojureScript
- Understand ClojureScript
  - JavaScript interop
  - Google Closure
  - macros
  - concurrency
- Add ClojureScript Support
  - using `lein-cljsbuild`
  - automatic re-compilation
- Build the UI with **Reagent**
  - Reagent components: based on Hiccup, `reagent.dom/render`
  - reimplementing the form
  - talking to the server: `cljs-ajax`
  - share code with the client
  - reimplementing the list
  - state in Reagent
- Managing State with **Re-Frame**
  - `app-db`: read using subscription, write using dispatching events
  - introudcing Re-Frame

# 5. Setting Up for Success
- Services
  - guestbook messages
  - configuring a service API
    - Swagger tools
    - coercion and validation with Reitit
    - debugging Reitit Middleware
    - using Swagger UI
- ClojureScript Development Tools
  - `shadlow-cljs`
  - `re-frisk`, `re-frame-10x`
  - the importance of a tight feedback loop
- Embracing Re-Frame
  - (1) define view/视图 using layers of pure functions(subscriptions) 
  - (2) define state transitions/状态转换 as data (events) to be handing using pure functions (event handlers)
  - views in Re-Frame
  - updating our view
  - initializing our Re-Frame application
  - reloading messages
- Multi-User with WebSockets
  - configuring the server: HTTP Kit
  - connecting from ClojureScript: `js/WebSocket`
- Upgrading to Sente
  - upgrading the server
  - upgrading the client
  - leveraging Sente callbacks
- Events/事件 and Effects/作用 in Re-Frame
  - event: pure application logic, effect: impure and fiddly such as AJAX
  - effect handlers
  - using Reagent atoms to reduce event noise

# 6. Planning Our Application

TODO: guestbook application to micro-blogging platform - 2025-12-22

- What’s in Our MVP?
- The Elephant in the Room
- Data Modeling
- Adding User Management

# 7. Account Management
- Authorship
- Add Author’s Posts Page
- Account Customization
- Account Settings

# 8. Social Interaction
- Improving Posts
- Curating Posts

# 9. Deployment
- Unit Tests
- Package the Application

# 10. Exercises
- How to Read This Chapter
- Code Quality
- Feature Enhancements

# A1. Clojure Primer
- A Functional Perspective
- Data Types
- Using Functions
- Anonymous Functions
- Named Functions
- Higher-Order Functions
- Closures
- Threading Expressions
- Being Lazy
- Structuring the Code
- Destructuring Data
- Namespaces
- Dynamic Variables
- Polymorphism
- What About Global State?
- Writing Code That Writes Code for You
- The Read-Evaluate-Print Loop
- Calling Out to Java
- Calling Methods
- Reader Conditionals

# A2. Editor Configuration
- Why Is Editor Integration So Important?
- General Configuration Tips
- VSCode + Calva
- IntelliJ IDEA + Cursive
- Emacs + Cider
- Vim

# A3. Working with EDN and Transit
- EDN
- Transit

# A4. Database Access
- Work with Relational Databases
- Use HugSQL
- Generate Reports

# A5. Writing RESTful Web Services with Liberator
- Using Liberator
- Defining Resources
- Putting It All Together

# A6. Leiningen Templates
- What’s in a Template
