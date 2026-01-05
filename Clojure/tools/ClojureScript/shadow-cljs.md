# shadow-cljs
* https://github.com/thheller/shadow-cljs

> shadow-cljs provides everything you need to compile your ClojureScript code with a focus on simplicity and ease of use.

Features
- Good configuration defaults so you don't have to sweat the details
- Seamless `npm` integration
- Fast builds, reliable caching, ...
- Supporting various targets `:browser`, `:node-script`, `:npm-module`, `:react-native`, `:chrome-extension`, ...
- Live Reload (CLJS + CSS)
- CLJS REPL
- Code splitting (via `:modules`)

# Setup

```shell
$ npx create-cljs-project acme-app

# tree
├── node_modules (omitted ...)
├── package.json
├── package-lock.json
├── shadow-cljs.edn
└── src
    ├── main
    └── test
```

REPL
```shell
$ npx shadow-cljs node-repl
# or
$ npx shadow-cljs browser-repl
```