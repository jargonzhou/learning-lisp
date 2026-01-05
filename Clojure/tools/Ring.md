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

# See Alos
* [ring-webjars](https://github.com/weavejester/ring-webjars): Ring middleware to serve assets from WebJars.
* [WebJars](https://www.webjars.org/): WebJars are client-side web libraries (e.g. jQuery & Bootstrap) packaged into JAR (Java Archive) files.