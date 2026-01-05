# Reagent
* https://github.com/reagent-project/reagent

> A minimalistic ClojureScript interface to React.js.
>
> Reagent provides a way to write efficient React components using (almost) nothing but plain ClojureScript functions.

Reagent uses [Hiccup-like](https://github.com/weavejester/hiccup) markup instead of JSX.

# Setup

```shell
lein new reagent myproject
# without a Clojure backend
lein new reagent-frontend myproject

# when using e.g. Shadow-cljs
npm i react@19.2.0 react-dom@19.2.0
```