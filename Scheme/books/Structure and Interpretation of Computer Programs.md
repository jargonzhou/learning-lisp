# Structure and Interpretation of Computer Programs
* https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html

涉及的概念有:
- 过程抽象,
- 数据抽象,
- 模块化, 对象, 状态,
- 元语言抽象,
- 寄存器机器计算.

code: [SICP.md](../codes/sicp/SICP.md)

# 1 Building Abstractions with Procedures
## 1.1 The Elements of Programming
- Expressions
- Naming and the Environment
- Evaluating Combinations
- Compound Procedures
- The Substitution Model for Procedure Application
- Conditional Expressions and Predicates
- Example: Square Roots by Newton's Method
- Procedures as Black-Box Abstractions
## 1.2 Procedures and the Processes They Generate
- Linear Recursion and Iteration
- Tree Recursion
- Orders of Growth
- Exponentiation
- Greatest Common Divisors
- Example: Testing for Primality
## 1.3 Formulating Abstractions with Higher-Order Procedures
- Procedures as Arguments
- Constructing Procedures Using Lambda
- Procedures as General Methods
- Procedures as Returned Values

# 2 Building Abstractions with Data
## 2.1 Introduction to Data Abstraction
- Example: Arithmetic Operations for Rational Numbers
- Abstraction Barriers
- What Is Meant by Data?
- Extended Exercise: Interval Arithmetic
## 2.2 Hierarchical Data and the Closure Property
- Representing Sequences
- Hierarchical Structures
- Sequences as Conventional Interfaces
- Example: A Picture Language
## 2.3 Symbolic Data
- Quotation
- Example: Symbolic Differentiation
- Example: Representing Sets
- Example: Huffman Encoding Trees
## 2.4 Multiple Representations for Abstract Data
- Representations for Complex Numbers
- Tagged data
- Data-Directed Programming and Additivity
## 2.5 Systems with Generic Operations
- Generic Arithmetic Operations
- Combining Data of Different Types
- Example: Symbolic Algebra

# 3 Modularity, Objects, and State
## 3.1 Assignment and Local State
- Local State Variables
- The Benefits of Introducing Assignment
- The Costs of Introducing Assignment
## 3.2 The Environment Model of Evaluation
- The Rules for Evaluation
- Applying Simple Procedures
- Frames as the Repository of Local State
- Internal Definitions
## 3.3 Modeling with Mutable Data
- Mutable List Structure
- Representing Queues
- Representing Tables
- A Simulator for Digital Circuits
- Propagation of Constraints
## 3.4 Concurrency: Time Is of the Essence
- The Nature of Time in Concurrent Systems
- Mechanisms for Controlling Concurrency
## 3.5 Streams
- Streams Are Delayed Lists
- Infinite Streams
- Exploiting the Stream Paradigm
- Streams and Delayed Evaluation
- Modularity of Functional Programs and Modularity of Objects

# 4 Metalinguistic Abstraction
## 4.1 The Metacircular Evaluator
- The Core of the Evaluator
- Representing Expressions
- Evaluator Data Structures
- Running the Evaluator as a Program
- Data as Programs
- Internal Definitions
- Separating Syntactic Analysis from Execution
## 4.2 Variations on a Scheme -- Lazy Evaluation
- Normal Order and Applicative Order
- An Interpreter with Lazy Evaluation
- Streams as Lazy Lists
## 4.3 Variations on a Scheme -- Nondeterministic Computing
- Amb and Search
- Examples of Nondeterministic Programs
- Implementing the Amb Evaluator
## 4.4 Logic Programming
- Deductive Information Retrieval
- How the Query System Works
- Is Logic Programming Mathematical Logic?
- Implementing the Query System

# 5 Computing with Register Machines
## 5.1 Designing Register Machines
- A Language for Describing Register Machines
- Abstraction in Machine Design
- Subroutines
- Using a Stack to Implement Recursion
- Instruction Summary
## 5.2 A Register-Machine Simulator
- The Machine Model
- The Assembler
- Generating Execution Procedures for Instructions
- Monitoring Machine Performance
## 5.3 Storage Allocation and Garbage Collection
- Memory as Vectors
- Maintaining the Illusion of Infinite Memory
## 5.4 The Explicit-Control Evaluator
- The Core of the Explicit-Control Evaluator
- Sequence Evaluation and Tail Recursion
- Conditionals, Assignments, and Definitions
- Running the Evaluator

## 5.5 Compilation
- Structure of the Compiler
- Compiling Expressions
- Compiling Combinations
- Combining Instruction Sequences
- An Example of Compiled Code
- Lexical Addressing
- Interfacing Compiled Code to the Evaluator

# See Also
* [SICP in Guile & Emacs Lisp](https://github.com/zv/SICP-guile)
