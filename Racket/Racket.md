# Racket
* https://racket-lang.org/
* https://github.com/racket/racket
* [Racket (programming language) - wikipedia](https://en.wikipedia.org/wiki/Racket_(programming_language))

> Welcome to Racket
> 
> Depending on how you look at it, Racket is
> 
> - **a programming language**—a dialect of Lisp and a descendant of Scheme;
> - **a family of programming languages**—variants of Racket, and more; or
> - **a set of tools**—for using a family of programming languages.
>
> Where there is no room for confusion, we use simply Racket.
>
> Racket’s main tools are
>
> - **racket**, the core compiler, interpreter, and run-time system/编译器, 解释器, 运行时系统;
> - **DrRacket**, the programming environment/编程环境; and
> - **raco**, a command-line tool for executing Racket commands that install packages, build libraries, and more/命令行工具, 执行安装包, 构件库等Racket命令.

Racket, the Programming Language
- **Mature**: Racket is a mature and stable product. From the beginning, it has supported cross-platform graphical programming (Windows, macOS, Linux).
  - Package System
  - GUI Framework
  - Standalone Binaries
  - Foreign Interface
- **Practical**: Racket includes a rich set of libraries, covering the full range from web server apps to mathematics and scientific simulation software.
  - Web Applications
  - Database
  - Math & Statistics
  - ...
- **Extensible**: In Racket, programmers define their own loops with **powerful macros**. Indeed, these macros are so powerful that programmers make entire **domain-specific languages** as libraries. No tools, no Makefiles required.
  - Intro To Macros
  - Macros In Depth
  - Making New Languages
  - Sample #Langs
- **Robust**: Racket is the first language to support **higher-order software contracts/高阶软件契约** and **safe gradual typing/安全的渐进式类型**. Programmers can easily deploy these tools to harden their software.
  - The Contract Guide
  - High-Order Contracts
  - The Typed Racket Guide
  - Gradual Typing
- **Polished**: Racket comes with support for major editors. The main bundle includes an innovative and extensible interactive development environment that has inspired other IDE projects.
  - DrRacket Guide
  - VS Code/Magic Racket
  - Emacs Integration
  - Vim Integration

Racket, the Language-Oriented Programming Language
- **Little Macros**
  - Racket allows programmers to **add new syntactic constructs/添加新的语法构造** in the same way that other languages permit the formulation of procedures, methods, or classes. All you need to do is formulate a simple rule that rewrites a custom syntax to a Racket expression or definition.
  - Little macros can particularly help programmers with DRY where other features can’t. The example on the left shows how to define a new syntax for measuring the time a task takes. The syntax avoids the repeated use of lambda. Note also how the macro is exported from this module as if it were an ordinary function.
- **General Purpose**
  - Racket comes with a comprehensive suite of libraries: **a cross-platform GUI toolbox**, a **web server**, and more. **Thousands of additional packages** are **a single command** away: 3D graphics, a bluetooth socket connector, color maps, data structures, educational software, games, a quantum-random number generator, scientific simulations, web script testing, and many more.
  - Macros work with these tools. The example on the left shows the implementation of a small number-guessing game. It is implemented in the GUI dialect of Racket, and demonstrates a number of language features.
- **Big Macros**
  - Getting to know the full Racket macro system will feel liberating, empowering, dazzling—like a whole new level of enlightenment. Developers can easily create a collection of co-operating macros to implement **algebraic pattern matching/代数模式匹配**, simple **event-handling/实践处理**, or a **logic-constraint solver/逻辑约束求解器**.
  - While Racket is a functional language, it has offered a sub-language of **classes and objects, mixins and traits**, from the beginning. The macro-based implementation of a Java-like class system lives in a library and does not need any support from the core language. A Racket programmer can thus combine functional with object-oriented components as needed.
- **Easy DSLs**
  - Some languages convey ideas more easily than others. And some programming languages convey solutions better than others. Therefore Racket is a language for **making languages/创造语言**, so that a programmer can write every module in a well-suited language.
  - Often **an application domain** comes with several languages. When you need a new language, you make it—on the fly. Open an IDE window; create a language right there, with just a few keystrokes; and run a module in this new language in a second IDE window. Making new languages really requires no setup, no project files, no external tools, no nothing.
- **IDE Support**
  - Racket comes with its own IDE, **DrRacket** (née DrScheme), and it sports some unique features. For example, when a programmer mouses over an identifier, the IDE draws an arrow back to where it was defined.
  - A programmer immediately benefits from DrRacket while using an alternative language, say **Typed Racket**. Racket macros, even complex ones and those used to make new languages, record and propagate a sufficient amount of source information for DrRacket to act as if it understood the features of the new language.
- **Any Syntax**
  - Racket programmers usually love parentheses, but they have empathy for those who need commas and braces. Hence, building languages with conventional surface syntax, like that of **datalog**, is almost as easy as building parenthetical languages.
  - Racket’s ecosystem comes with **parsing packages/解析包** that allow developers to easily map any syntax to a parenthesized language, which is then compiled to ordinary Racket with the help of Racket’s macro system. Such a language can also exploit the hooks of the IDE framework, so that its programmers may take advantage of Racket’s IDE.

Racket, the Ecosystem
- Software
  - Download Racket
  - Source Code
  - Bug Reports
  - Nightly Snapshot Builds
  - Packages
- Tutorials & Documentation
  - Quick Introduction
  - Systems Programming
  - The Racket Guide
  - The Racket Reference
  - Web Applications
  - All Documentation
- Community
- Books: https://racket-lang.org/books.html
- Education
- Swag

# Book
* [Realm of Racket](./books/Realm%20of%20Racket.md)
* [Racket Programming the Fun Way](./books/Racket%20Programming%20the%20Fun%20Way.md)

# Documentation
* https://docs.racket-lang.org/

- Getting Started
- Racket Cheat Sheet
- Tutorials/教程
	- Quick: An Introduction to Racket with Pictures
	- Continue: Web Applications in Racket
	- More: Systems Programming with Racket
- Racket Language and Core Libraries/Racket语言和核心库
	- The Racket Guide
	- The Racket Reference
	- Package Management in Racket
	- The Racket Drawing Toolkit
	- The Racket Graphical Interface Toolkit
	- The Racket Foreign Interface
	- Scribble: The Racket Documentation Tool
	- DrRacket: The Racket Programming Environment
	- raco: Racket Command-Line Tools
	- How to Program Racket: a Style Guide
- Teaching/教学
	- [How to Design Programs/**htdp**](./books/How%20to%20Design%20Programs.md)
	- [*How to Design Programs* Languages/语言](./books/How%20to%20Design%20Programs/htdp.languages.md)
	- [*How to Design Programs* Teachpacks/教学包](./books/How%20to%20Design%20Programs/htdp.teachpacks.md)
	- *Essentials of Programming Languages* Language
	- *Programming Languages: Application and Interpretation*
	- *Picturing Programs* Teachpack/图形程序教学包
	- Sprachebenen und Material zu Schreibe Dein Programm!: German textbook 'Schreibe Dein Programm!'.
	- *Category Theory in Programming*
- Other Languages in the Racket Environment/Racket环境中其他语言
	- The Typed Racket Guide
	- The Typed Racket Reference
	- R6RS: Scheme
	- Datalog: Deductive Database Programming
	- Swindle
- Tools/工具
	- Web Applications in Racket
	- Futures Visualizer
	- PLaneT: Automatic Package Distribution
	- Redex: Practical Semantics Engineering
	- Scribble as Preprocessor
	- Slideshow: Figure and Presentation Tools
	- Web Server: HTTP Server
	- DrRacket Plugins
	- DrRacket Tools
- GUI and Graphics Libraries/用户图形界面和图形库
	- Framework: Racket GUI Application Framework
	- Pict Snip: Build Snips from Picts
	- Pict: Functional Pictures
	- Browser: Simple HTML Rendering
	- Cards: Virtual Playing Cards Library
	- Embedded GUI: Widgets Within Editors
	- Games: Fun Examples
	- GL Board Game: 3-D Game Support
	- GL: 3-D Graphics
	- Images
	- MrLib: Extra GUI Libraries
	- Plot: Graph Plotting
	- String Constants: GUI Internationalization
	- Syntax Color: Utilities
	- Turtle Graphics
- Network Libraries/网络库
	- Distributed Places
	- Mac OS Native SSL: Secure Communication
	- Net: Networking Libraries
	- OpenSSL: Secure Communication
	- SASL: Simple Authentication and Security Layer
	- Unix Domain Sockets
	- Windows Native SSL: Secure Communication
- Parsing Libraries/解析库
	- File: Racket File and Format Libraries
	- HTML: Parsing Library
	- JSON
	- Parser Tools: lex and yacc-style Parsing
	- XML: Parsing and Writing
- Tool Libraries/工具库
	- Dynext: Running a C Compiler/Linker
	- Errortrace: Debugging and Profiling
	- Expeditor: Terminal Expression Editor
	- Macro Debugger: Inspecting Macro Expansion
	- Make: Dependency Manager
	- Readline: Terminal Interaction
	- SLaTeX Wrapper
	- Source Syntax
	- Test Support
	- Trace: Instrumentation to Show Function Calls
	- Version: Racket Version Checking
	- XREPL: eXtended REPL
- Low-Level APIs/低层API
	- Inside: Racket C API
- Interoperability/互操作
	- MzCOM: Racket as a Windows COM Object
- DrRacket Plugins/DrRacket插件
	- Quickscript, a scripting plugin for DrRacket
- Data Structures/数据结构
	- Data: Data Structures
- Databases/数据库
	- DB: Database Connectivity
- Logic programming/逻辑编程
	- Racklog: Prolog-Style Logic Programming
- Math and Science/数学和科学
	- Math Library
- Performance Tools/性能工具
	- Contract Profiling
	- Optimization Coach
	- Profile: Statistical Profiler
- Scribble Libraries/Scribble库
	- Scriblib: Extra Scribble Libraries
- Syntax Extensions/语法扩展
	- 2D Syntax
	- Syntax: Meta-Programming Helpers
- Testing/测试
	- RackUnit: Unit Testing
- Miscellaneous Libraries/其他库
	- SRFIs: Libraries
	- Bug Reporting
	- Cookies: HTTP State Management
	- DrRacket Version Tool
	- GUI ".plt" Installer
	- Help and Documentation Utilities
	- Implementing HtDP Teachpacks, Libraries, and Customized Teaching Languages
	- Option Contracts
	- Reading Writing ".DS_Store" Files
	- Simple Tree Text Markup: Simple Markup for Display as Text or in GUI
	- The Stepper
- Experimental Languages and Libraries/实验性语言和库
	- FrTime: A Language for Reactive Programs
	- Lazy Racket
	- Algol 60
- Legacy Languages and Libraries/遗留语言和库
	- R5RS: Legacy Scheme
	- Scheme: Compatibility Libraries and Executables
	- Compatibility: Features from Racket Relatives
	- Graphics: Legacy Library
	- Legacy Print Convert
	- MysterX: Legacy Support for Windows COM
	- MzLib: Legacy Libraries
	- mzpp and mztext: Preprocessors
	- MzScheme: Legacy Language