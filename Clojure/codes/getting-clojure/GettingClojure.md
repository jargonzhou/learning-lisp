# Getting Clojure
* https://pragprog.com/titles/roclojure/getting-clojure/

> Behind every programming language lies a **vision** of how programs should be built. The vision behind Clojure is of a radically simple language framework holding together a sophisticated collection of programming features. Learning Clojure involves much more than just learning the mechanics of the language. To really **get** Clojure you need to understand the **ideas** underlying this structure of framework and features. You need this book: an accessible introduction to Clojure that focuses on the ideas behind the language as well as the practical details of writing code.

# Setup
- Leiningen: `lein new app getting-clojure`
- VSCode Calva
```shell
clj꞉getting-clojure.core꞉> 
; Jack-in done.
clj꞉getting-clojure.core꞉> 
; Evaluating file: core.clj
#'getting-clojure.core/-main
clj꞉getting-clojure.core꞉> (getting-clojure.core/-main)
; Hello, World!
nil
```

# Deps


# Basics

## 1. Hello, Clojure
- The Very Basics
- Arithmetic
- Not Variable Assignment, but Close
- A Function of Your Own

## 2. Vectors and Lists
- One Thing After Another
- A Toolkit of Functions
- Growing Your Vectors
- Lists
- Lists versus Vectors

## 3. Maps, Keywords, and Sets
- This Goes with That
- Keywords
- Changing Your Map Without Changing It
- Other Handy Map Functions
- Sets

## 4. Logic
- The Fundamental If
- Asking Questions
- Truthy and Falsy
- Do and When
- Dealing with Multiple Conditions
- Throwing and Catching

## 5. More Capable Functions
- One Function, Different Parameters
- Arguments with Wild Abandon
- Multimethods
- Deeply Recursive
- Docstrings
- Pre and Post Conditions

## 6. Functional Things
- Functions Are Values
- Functions on the Fly
- A Functional Toolkit
- Function Literals

## 7. Let
- A Local, Temporary Place for Your Stuff
- Let Over Fn
- Variations on the Theme

## 8. Def, Symbols, and Vars
- A Global, Stable Place for Your Stuff
- Symbols Are Things
- Bindings Are Things Too
- Varying Your Vars

## 9. Namespaces
- A Place for Your Vars
- Loading Namespaces
- A Namespace of Your Own
- As and Refer
- Namespaces, Symbols, and Keywords


# Intermediate 
## 10. Sequences
- One Thing After Another
- A Universal Interface
- A Rich Toolkit …
- … Made Richer with Functional Values
- Map
- Reduce
- Composing a Solution
- Other Sources of Sequences

## 11. Lazy Sequences
- Sequences Without End
- More Interesting Laziness
- Lazy Friends
- Laziness in Practice
- Behind the Scenes

## 12. Destructuring
- Pry Open Your Data
- Getting Less than Everything
- Destructuring in Sequence
- Destructuring Function Arguments
- Digging into Maps
- Diving into Nested Maps
- The Final Frontier: Mixing and Matching
- Going Further

## 13. Records and Protocols
- The Trouble with Maps
- Striking a More Specific Bargain with Records
- Records Are Maps
- The Record Advantage
- Protocols
- Decentralized Polymorphism
- Record Confusion

## 14. Tests
- Spotting Bugs with clojure.test
- Testing Namespaces and Projects
- Property-Based Testing
- Checking Properties

## 15. Spec
- This Is the Data You’re Looking For
- Spec’ing Collections
- Registering Specs
- Spec’ing Maps (Again)
- Why? Why? Why?
- Function Specs
- Spec-Driven Tests

# Advanced
## 16. Interoperating with Java
- A Peek at Java …
- … And Back to Clojure
- Packages
- Class Methods and Fields

## 17. Threads, Promises, and Futures
- Great Power …
- … And Great Responsibility
- Good Fences Make Happy Threads
- Promise Me a Result
- A Value with a Future

## 18. State
- It’s Made of Atoms
- Swapping Maps
- Refs: Team-Oriented Atoms
- Agents
- Choose Wisely

## 19. Read and Eval
- You Got Data On My Code!
- Reading and Evaluating
- The Homoiconic Advantage
- An Eval of Your Own

## 20. Macros
- There Are Three Kinds of Numbers in the World
- Macros to the Rescue
- Easier Macros with Syntax Quoting

## 21. Conclusion