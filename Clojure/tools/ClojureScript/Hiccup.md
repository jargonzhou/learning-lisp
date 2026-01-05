# Hiccup
* https://github.com/weavejester/hiccup

> Fast library for rendering HTML in Clojure

# Examples

```clojure
(require '[hiccup2.core :as h])

user=> (str (h/html [:span {:class "foo"} "bar"]))
"<span class=\"foo\">bar</span>"
user=> (str (h/html [:script]))
"<script></script>"
user=> (str (h/html [:p]))
"<p />"

; shortcut for id, class properties: #<id>.<class>
user=> (str (h/html [:div#foo.bar.baz "bang"]))
"<div id=\"foo\" class=\"bar baz\">bang</div>"

; seq body
user=> (str (h/html [:ul
                     (for [x (range 1 4)]
                       [:li x])]))
"<ul><li>1</li><li>2</li><li>3</li></ul>"

; string escaped
user=> (str (h/html [:p "Tags in HTML are written with <>"]))
"<p>Tags in HTML are written with &lt;&gt;</p>"
user=> (str (h/html [:p (h/raw "Hello <em>World</em>")]))
"<p>Hello <em>World</em></p>"
user=> (str (h/html (h/raw "<!DOCTYPE html>") [:html {:lang "en"}]))
"<!DOCTYPE html><html lang=\"en\"></html>"
```