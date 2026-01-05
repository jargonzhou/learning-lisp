# ClojureScript: Up and Running
* https://www.oreilly.com/library/view/clojurescript-up-and/9781449327422/

```clojure
:dependencies [
  [org.clojure/clojure "1.4.0"]
  [org.clojure/clojurescript "0.0-1450"]]

:plugins [[lein-cljsbuild "0.2.7"]]
```

# 1. Introduction: Why ClojureScript?
- The Rise of Browser Applications
- The Rise of JavaScript
- The Need for a Better Language
- Introducing ClojureScript

# 2. Hello World
- Leiningen
- Using lein-cljsbuild
  - Getting Started with the REPL
  - Compiling a ClojureScript File to JavaScript
  - Running ClojureScript in the Browser
  - Other Capabilities of lein-cljsbuild

# 3. The Compilation Process
- Architecture
  - Google Closure Compiler
  - The Google Closure Library
  - ClojureScript and Google Closure
  - The Compilation Pipeline
- How to Compile
  - Compiling ClojureScript
- Compilation in Depth
  - Compilation Sources
  - Compilation and Optimization Options
  - Other Compilation Options

# 4. ClojureScript Basics
- ClojureScript versus Clojure
- Expressions and Side Effects
- Syntax and Data Structures
  - Symbols and Keywords
  - Data Structures
- Special Forms and Definitions
- Functions
  - Multi-Arity Functions
  - Variadic Functions
- Local Bindings
  - Destructuring
- Closures
- Flow Control
  - Conditional Branching
- JavaScript Interop
  - The js Namespace
  - Methods and Fields
  - Constructor Functions
  - Scope of this
  - Exceptions

# 5. Data and State
- Primitives
  - Strings
  - Keywords
  - Symbols
  - Characters
  - Numbers
  - Booleans
  - Functions
  - nil
- Data Structures
  - Collection Types: Lists, Vectors, Maps, Sets
  - Immutability
  - Persistence
- Identity and State
  - Atoms

# 6. Sequences
- The Sequence Abstraction
- Lazy Sequences
  - Letting Go of the Head
- The Sequence API
  - map
  - reduce
  - filter
  - Other Useful Sequence Functions
    - cons, count, nth, take, drop, concat, reverse
    - lazy-seq macro

# 7. Namespaces, Libraries, and Google Closure
- Namespaces
  - Using Namespaces
  - Using Namespaces Effectively
  - The Implementation of Namespaces
- Advanced Compilation Mode
- Consuming Libraries
  - ClojureScript Libraries
  - JavaScript Libraries
- Creating Libraries
  - For Consumption by ClojureScript
  - For Consumption by JavaScript

# 8. Macros
- Code as Data
- Writing Macros
  - Syntax-Quote
  - Auto-Gensyms
- Using Macros
- When to Write Macros

# 9. Development Process and Workflow
- Installing ClojureScript
  - Checking Out from Source Control
  - Downloading a Compressed Archive
  - Installing Dependencies
- The Built-In Tools
  - Command-Line Compilation: `cljsc`
  - Clojure REPL
  - ClojureScript REPL
- The Browser REPL
  - Setting Up the Browser REPL
- Additional lein-cljsbuild Features
  - Launching a Browser REPL
  - Custom bREPL Launch Commands
  - Hooking Into Default Leiningen Tasks
  - Testing ClojureScript Code
  - Including ClojureScript in JAR Files
  - Compiling the Same Code as Clojure and ClojureScript

# 10. Integration with Clojure
- AJAX: `goog.net.XhrIo`
- The Reader and Printer: `goog.json.Serializer`, `cljs.reader`
- Example Client-Server Application
- Extending the Reader
  - User-Defined Tagged Literals
- Sharing Code

# A. Libraries
- ClojureScript’s Standard Library
- Google Closure Library
- Domina
- Enfocus
- Jayq
- C2
- core.logic

# See Also
* **Closure: The Definitive Guide**. by Michael Bolin
* [JavaScript is Assembly Language for the Web: Part 2 - Madness or just Insanity?](https://www.hanselman.com/blog/javascript-is-assembly-language-for-the-web-part-2-madness-or-just-insanity) - 2011-07-19
* [PhantomJS](https://github.com/ariya/phantomjs): PhantomJS is a headless WebKit scriptable with JavaScript. - archived 2023-05-30
* [Rhino](https://github.com/mozilla/rhino): Rhino is an open-source implementation of JavaScript written entirely in Java.
