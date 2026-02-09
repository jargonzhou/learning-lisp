# Ring
* https://github.com/ring-clojure/ring

> Ring is a Clojure web applications library inspired by Python's WSGI and Ruby's Rack. By abstracting the details of HTTP into a simple, unified API, Ring allows web applications to be constructed of modular components that can be shared among a variety of applications, web servers, and web frameworks.

# Libraries
- `ring/ring` - meta-package containing all relevant dependencies
- `ring/ring-core` - core functions and middleware for Ring handlers, requests and responses
- `org.ring-clojure/ring-core-protocols` - contains only the protocols necessary for building Ring responses
- `org.ring-clojure/ring-websocket-protocols` - contains only the protocols necessary for WebSockets
- `ring/ring-devel` - functions for developing and debugging Ring applications
- `ring/ring-servlet` - construct legacy Java Servlets (≤ 4.0) from Ring handlers
- `org.ring-clojure/ring-jakarta-servlet` construct [Jakarta Servlets](https://projects.eclipse.org/projects/ee4j.servlet) (≥ 5.0) from Ring handlers
- `ring/ring-jetty-adapter` - a Ring adapter that uses an embedded [Jetty](https://eclipse.dev/jetty/) web server

# Spec
* https://github.com/ring-clojure/ring/blob/master/SPEC.md

- 1. Synchronous API
  - 1.1. **Handlers**: Ring handlers constitute the core logic of the web application. Handlers are implemented as Clojure functions.
  - 1.2. **Middleware**: Ring middlware augment the functionality of handlers. Middleware is implemented as higher-order functions that take one or more handlers and configuration options as arguments and return a new handler with the desired additional behavior.
  - 1.3. **Adapters**: Ring adapters are side-effectful functions that take a handler and a map of options as arguments, and when invoked start a HTTP server.
  - 1.4. **Request Maps**: A Ring request map represents a HTTP request.
  - 1.5. **Response Maps**: A Ring response map represents a HTTP response.
- 2. Asynchronous API
  - 2.1. **Handlers**: An asynchronous handler takes 3 arguments: a request map, a callback function for sending a response and a callback function for raising an exception.
  - 2.2. **Adapters**: An adapter may support synchronous handlers, or asynchronous handlers, or both.
- 3. Websockets
  - 3.1. **Websocket Responses**: A websocket response is a map that represents a WebSocket, and may be returned from a handler in place of a response map.
  - 3.2. **Websocket Listeners**: A websocket listener must satisfy the `ring.websocket.protocols/Listener` protocol.
    - It may optionally satisfy the `ring.websocket.protocols/PingListener` protocol.
  - 3.3. **Websocket Sockets**: A socket must satisfy the `ring.websocket.protocols/Socket` protocol.
    - It may optionally satisfy the `ring.websocket.protocols/AsyncSocket` protocol.


# See Alos
* [ring-webjars](https://github.com/weavejester/ring-webjars): Ring middleware to serve assets from WebJars.
* [WebJars](https://www.webjars.org/): WebJars are client-side web libraries (e.g. jQuery & Bootstrap) packaged into JAR (Java Archive) files.