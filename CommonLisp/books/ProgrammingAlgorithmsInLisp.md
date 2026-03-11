# Programming Algorithms in Lisp

# 1 Introduction
## 1.1 Why Algorithms Matter
## 1.2 A Few Words About Lisp
  
# 2 Algorithmic Complexity
  
# 3 A Crash Course in Lisp
## 3.1 The Core of Lisp
## 3.2 A Code Example
  
```lisp
;;; algorithm
;;;
;;; binary search
(let ((vec #(1 2 3 4 5))
      (val 4))
  (when (> (length vec) 0)
    (let ((beg 0)
          (end (length vec)))
      (do ()
          ((= beg end))
        (let ((mid (floor (+ beg end) 2)))
          (if (> (aref vec mid) val)
              (setf end mid)
              (setf beg (1+ mid)))))
      (values beg
              (aref vec beg)
              (= (aref vec beg) val)))))
```
  
  
## 3.3 The REPL
## 3.4 Basic Expressions
  
- Sequential Execution
  
```lisp
block
return-from
return
progn
```
  
- Branching
  
```lisp
if
when
unless
cond
```
  
- Looping
  
```lisp
dotimes
do
loop
```
  
- Procedures and Variables
  
```lisp
lambda
defun
  
let
let*
  
with ; RUTILS
  
setf
defparameter
  
funcall
flet
```
  
- Comments
  
```lisp
;;;
;;
;
```
  
## 3.5 Getting Started
  
```shell
apt-get install sbcl rlwrap
rlwrap sbcl
* (print "hello world")
  
sbcl --script hello.lisp
```
  
- `RUTILS` library
```shell
* (ql:quickload :rutils)
* (named-readtables:in-readtable rtl:rutils-readtable)
```
  
# 4 Data Structures
## 4.1 Data Structures vs Algorithms
## 4.2 The Data Structure Concept
## 4.3 Contiguous and Linked Data Structures
## 4.4 Tuples
## 4.5 Passing Data Structures in Function Calls
## 4.6 Structs in Action: Union-Find
  
# 5 Arrays
## 5.1 Arrays as Sequences
## 5.2 Dynamic Vectors
## 5.3 Why Are Arrays Indexed from 0
## 5.4 Multidimensional Arrays
## 5.5 Binary Search
- Binary Search in Action: A Fast Specialized In-Memory DB
## 5.6 Sorting
- O(n^2) Sorting
- Quicksort
- Production Sort
- Performance Benchmark
  
# 6 Linked Lists
## 6.1 Lists as Sequences
## 6.2 Lists as Functional Data Structures
## 6.3 Different Kinds of Lists
## 6.4 FIFO and LIFO
- Queue
- Stack
- Deque
- Stacks in Action: SAX Parsing
## 6.5 Lists as Sets
## 6.6 Merge Sort
- Parallelization of Merge Sort
## 6.7 Lists and Lisp
  
# 7 Key-Values
## 7.1 Concrete Key-values
- Simple Arrays
- Associative Lists
- Hash-Tables
- Structs
- Trees
## 7.2 Operations
## 7.3 Memoization
- Memoization in Action: Transposition Tables
## 7.4 Cache Invalidation
- Second Chance and Clock Algorithms
- LFU
- LRU
## 7.5 Low-Level Caching
  
# 8 Hash-Tables
## 8.1 Implementation
- Dealing with Collisions
- Hash-Code
- Advanced Hashing Techniques
## 8.2 Hash-Functions
## 8.3 Operations
- Initialization
- Access
- Iteration
## 8.4 Perfect Hashing
- Implementation
- The CHM92 Algorithm
## 8.5 Distributed Hash-Tables
## 8.6 Hashing in Action: Content Addressing
  
# 9 Trees
## 9.1 Implementation Variants
## 9.2 Tree Traversal
## 9.3 Binary Search Trees
## 9.4 Splay Trees
- Complexity Analysis
## 9.5 Red-Black and AVL Trees
## 9.6 B-Trees
## 9.7 Heaps
## 9.8 Tries
## 9.9 Trees in Action: Efficient Mapping
  
# 10 Graphs
## 10.1 Graph Representations
## 10.2 Topological Sort
## 10.3 MST
- Prim’s Algorithm
- Kruskal’s Algorithm
## 10.4 Pathfinding
- Dijkstra’s Algorithm
- A* Algorithm
## 10.5 Maximum Flow
## 10.6 Graphs in Action: PageRank
- Implementation
  
# 11 Strings
## 11.1 Basic String-Related Optimizations
## 11.2 Strings in the Editor
## 11.3 Substring Search
- Knuth-Morris-Pratt (KMP)
- Boyer-Moore (BM)
- Rabin-Karp (RK)
- Aho-Corasick (AC)
## 11.4 Regular Expressions
- Implementation of Thompson’s Construction
## 11.5 Grammars
## 11.6 String Search in Action: Plagiarism Detection
  
# 12 Dynamic Programming
## 12.1 Fibonacci Numbers
## 12.2 String Segmentation
## 12.3 Text Justification
## 12.4 Pathfinding Revisited
## 12.5 LCS and Diff
## 12.6 DP in Action: Backprop
  
# 13 Approximation
## 13.1 Combinatorial Optimization
## 13.2 Local Search
## 13.3 Evolutionary Algorithms
## 13.4 Branch and Bound
## 13.5 Gradient Descent
- Improving GD
## 13.6 Sampling
## 13.7 Matrix Factorization
- Singular Value Decomposition
## 13.8 Fourier Transform
- Fourier Transform in Action: JPEG
  
# 14 Compression
## 14.1 Encoding
## 14.2 Base64
## 14.3 Lossless Compression
## 14.4 Huffman Coding
- Huffman Coding in Action: Dictionary Optimization
## 14.5 Arithmetic Coding
## 14.6 DEFLATE
  
# 15 Synchronization
## 15.1 Synchronization Troubles
## 15.2 Low-Level Synchronization
## 15.3 Mutual Exclusion Algorithms
## 15.4 High-Level Synchronization
- Lock-Free Data Structures
- Data Parallelism and Message Passing
- STM
## 15.5 Distributed Computations
- Distributed Algorithms
- Distributed Data Structures
- Distributed Algorithms in Action: Collaborative Editing
## 15.6 Persistent Data Structures