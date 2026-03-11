# Common Lisp Recipes: A Problem-Solution Approach


# 1 Symbols and Packages
## 1.1 Understanding the Role of Packages and the Symbol Nomenclature
## 1.2 Making Unique Symbols
## 1.3 Making Symbols Inaccessible
## 1.4 Avoiding Name Conflicts
## 1.5 Using Symbols As Stand-Ins for Arbitrary Forms
## 1.6 Searching for Symbols by Name
## 1.7 Iterating Through All Symbols of a Package
## 1.8 Understanding COMMON LISP's Case (In)Sensitivity
## 1.9 Using Symbols As String Substitutes
## 1.10 "Overloading" of Standard COMMON LISP Operators

# 2 Conses, Lists, and Trees
## 2.1 Understanding Conses
## 2.2 Creating Lists
## 2.3 Transposing a Matrix
## 2.4 Using List Interpolation
## 2.5 Adding Objects to the End of a List
## 2.6 "Splicing" into a List
## 2.7 Detecting Shared Structure in Lists
## 2.8 Working with Trees
## 2.9 Working with Stacks
## 2.10 Implementing a Queue
## 2.11 Destructuring and Pattern Matching

# 3 Strings and Characters
## 3.1 Getting the ASCII Code of a Character
## 3.2 Naming Characters
## 3.3 Using Different Character Encodings
## 3.4 Comparing Strings or Characters
## 3.5 Escaping Characters in String Literals and Variable Interpolation
## 3.6 Controlling Case
## 3.7 Accessing or Modifying a Substring
## 3.8 Finding a Character or a Substring Within a String
## 3.9 Trimming Strings
## 3.10 Processing a String One Character at a Time
## 3.11 Joining Strings
## 3.12 Reading CSV Data

# 4 Numbers and Math
## 4.1 Using Arbitrarily Large Integers
## 4.2 Understanding Fixnums
## 4.3 Performing Modular Arithmetic
## 4.4 Switching Bases
## 4.5 Performing Exact Arithmetic with Rational Numbers

## 4.6 Controlling the Default Float Format
## 4.7 Employing Arbitrary Precision Floats
## 4.8 Working with Complex Numbers
## 4.9 Parsing Numbers
## 4.10 Testing Whether Two Numbers Are Equal
## 4.11 Computing Angles Correctly
## 4.12 Calculating Exact Square Roots

# 5 Arrays and Vectors
## 5.1 Working with Multiple Dimensions
## 5.2 Understanding Vectors and Simple Arrays
## 5.3 Obtaining the Size of an Array
## 5.4 Providing Initial Contents
## 5.5 Treating Arrays As Vectors
## 5.6 Making the Length of Vectors Flexible
## 5.7 Adjusting Arrays
## 5.8 Using an Array As a "Window" into Another Array
## 5.9 Restricting the Element Type of an Array
## 5.10 Copying an Array

# 6 Hash Tables, Maps, and Sets
## 6.1 Understanding the Basics of Hash Tables
## 6.2 Providing Default Values For Hash Table Lookups
## 6.3 Removing Hash Table Entries
## 6.4 Iterating Through a Hash Table
## 6.5 Understanding Hash Table Tests and Defining Your Own
## 6.6 Controlling Hash Table Growth
## 6.7 Getting Rid of Hash Table Entries Automatically
## 6.8 Representing Maps As Association Lists
## 6.9 Representing Maps As Property Lists
## 6.10 Working with Sets

# 7 Sequences and Iteration
## 7.1 Filtering a Sequence
## 7.2 Searching a Sequence
## 7.3 Sorting and Merging Sequences
## 7.4 Mixing Different Sequence Types
## 7.5 Re-Using a Part of a Sequence
## 7.6 Repeating Some Values Cyclically
## 7.7 Counting Down
## 7.8 Iterating over "Chunks" of a List
## 7.9 Closing over Iteration Variables
## 7.10 "Extending" Short Sequences in Iterations
## 7.11 Breaking out of LOOP
## 7.12 Making Sense of the MAP... Zoo
## 7.13 Defining Your Own Sequence Types
## 7.14 Iterating with ITERATE
## 7.15 Iterating with SERIES

# 8 The Lisp Reader
## 8.1 Employing the Lisp Reader for Your Own Code

## 8.2 Troubleshooting Literal Object Notation
## 8.3 Evaluating Forms at Read Time
## 8.4 Embedding Literal Arrays into Your Code
## 8.5 Understanding the Different Ways to Refer to a Function
## 8.6 Repeating Something You Already Typed
## 8.7 Safely Experimenting with Readtables
## 8.8 Changing the Syntax Type of a Character
## 8.9 Creating Your Own Reader Macros
## 8.10 Working with Dispatching Macro Characters
## 8.11 Preserving Whitespace

# 9 Printing
## 9.1 Using the Printing Primitives
## 9.2 Printing to and into Strings
## 9.3 Printing NIL As a List
## 9.4 Extending FORMAT Control Strings Over More Than One Line
## 9.5 Using Functions As FORMAT Controls
## 9.6 Creating Your Own FORMAT Directives
## 9.7 Recursive Processing of FORMAT Controls
## 9.8 Controlling How Your Own Objects Are Printed
## 9.9 Controlling the Pretty Printer
## 9.10 Printing Long Lists
## 9.11 Pretty-Printing Compound Objects
## 9.12 Modifying the Pretty Printer

# 10 Evaluation, Compilation, Control Flow
## 10.1 Comparing Arbitrary Lisp Objects
## 10.2 Using Constant Variables as Keys in CASE Macros
## 10.3 Using Arbitrary Variable Names for Keyword Parameters
## 10.4 Creating "Static Local Variables," Like in C
## 10.5 "Preponing" the Computation of Values
## 10.6 Modifying the Behavior of Functions You Don't Have the Source Of
## 10.7 Swapping the Values of Variables (or Places)
## 10.8 Creating Your Own Update Forms for "Places"

## 10.9 Working with Environments
## 10.10 Commenting Out Parts of Your Code

# 11 Concurrency
## 11.1 Managing Lisp Processes
## 11.2 Accessing Shared Resources Concurrently
## 11.3 Using Special Variables in Concurrent Programs
## 11.4 Communicating with Other Threads
## 11.5 Parallelizing Algorithms Without Threads and Locks

## 11.6 Determining the Number of Cores

# 12 Error Handling and Avoidance
## 12.1 Checking Types at Run Time
## 12.2 Adding Assertions to Your Code
## 12.3 Defining Your Own Conditions
## 12.4 Signaling a Condition
## 12.5 Handling Conditions
## 12.6 Providing and Using Restarts
## 12.7 Getting Rid of Warning Messages
## 12.8 Protecting Code from Non-Local Exits

# 13 Objects, Classes, Types
## 13.1 Defining Types
## 13.2 Using Classes As Types
## 13.3 Writing Methods for Built-In Classes
## 13.4 Providing Constructors for Your Classes
## 13.5 Marking Slots As "Private"
## 13.6 Changing the Argument Precedence Order
## 13.7 Automatically Initializing Slots on First Usage
## 13.8 Changing and Redefining Classes on the Fly
## 13.9 Making Your Objects Externalizable
## 13.10 Using and Defining Non-Standard Method Combinations
## 13.11 Extending and Modifying CLOS

# 14 I/O: Streams and Files
## 14.1 Redirecting Streams
## 14.2 Flushing an Output Stream
## 14.3 Determining the Size of a File
## 14.4 Reading a Whole File at Once
## 14.5 Sending Data to Two Streams in Parallel
## 14.6 Sending Data to "/dev/null"
## 14.7 Pretending a String Is a Stream
## 14.8 Concatenating Streams
## 14.9 Processing Text Files Line by Line
## 14.10 Working with Binary Data
## 14.11 Reading "Foreign" Binary Data
## 14.12 Using Random Access I/O
## 14.13 Serializing Lisp Objects

## 14.14 Customizing Stream Behavior

# 15 Pathnames, Files, Directories
## 15.1 Getting and Setting the Current Directory
## 15.2 Testing Whether a File Exists
## 15.3 Creating a Directory
## 15.4 Finding Files Matching a Pattern
## 15.5 Splitting a Filename into its Component Parts
## 15.6 Renaming a File
## 15.7 Deleting a File
## 15.8 Deleting a Directory
## 15.9 Copying a File
## 15.10 Processing the Contents of a Directory Recursively
## 15.11 Getting the Pathname a Stream Is Associated With
## 15.12 Dealing with Symbolic Links
## 15.13 Navigating a Directory Tree
## 15.14 Figuring Out (Source) File Locations Programmatically
## 15.15 Understanding Logical Pathnames

# 16 Developing and Debugging
## 16.1 Embracing Lisp's Image-Based Development Style
## 16.2 Deciding Which IDE to Use
## 16.3 Debugging with the Debugger
## 16.4 Tracing Functions
## 16.5 Stepping Through Your Code
## 16.6 Acquiring Information About Functions, Macros, and Variables
## 16.7 Inspecting and Modifying (Compound) Objects
## 16.8 Browsing Your Lisp Image
## 16.9 "Undoing" Definitions
## 16.10 Distinguishing Your IDE's Streams
## 16.11 Utilizing the REPL's Memory
## 16.12 Recording Your Work

# 17 Optimization
## 17.1 Understanding the Importance of the Right Algorithms
## 17.2 Deciding If and Where to Optimize

## 17.3 Asking the Compiler to Optimize
## 17.4 Obtaining Optimization Hints from the Compiler
## 17.5 Helping the Compiler by Providing Type Information

## 17.6 Reducing "Consing"

## 17.7 Using the Stack Instead of the Heap
## 17.8 Optimizing Recursive Functions
## 17.9 Helping the Compiler with Alternative Implementation Strategies
## 17.10 Avoiding Repeated Computations
## 17.11 Avoiding Function Calls
## 17.12 Utilizing the Disassembler
## 17.13 Switching to Machine Code
## 17.14 Optimizing Array Access
## 17.15 Comparing Different Implementations

# 18 Libraries
## 18.1 Organizing Your Code

## 18.2 Employing Open Source Libraries
## 18.3 Creating a Project's Skeleton Automatically
## 18.4 Avoiding Wheel-Reinvention
## 18.5 Using Libraries to Write Portable Code
## 18.6 Utilizing Regular Expressions

## 18.7 Obtaining Data via HTTP
## 18.8 Creating Dynamic Web Sites with Lisp

# 19 Interfacing with Other Languages
## 19.1 Calling C Functions from Lisp

## 19.2 Working with C Pointers
## 19.3 Accessing and Generating C Arrays
## 19.4 Handling C Structs and Unions
## 19.5 Converting Between Lisp and C Strings
## 19.6 Calling Lisp Functions from C
## 19.7 Generating FFI Code Automatically
## 19.8 Embedding C in COMMON LISP
## 19.9 Calling C++ from Lisp
## 19.10 Using JAVA from Lisp
## 19.11 Reading and Writing JSON
## 19.12 Reading and Writing XML
## 19.13 Using PROLOG from COMMON LISP

# 20 Graphical User Interfaces
## 20.1 Using a Web Browser as the GUI for Your Lisp Program
## 20.2 Building Applications with the "Lisp Toolkit"
## 20.3 Creating COMMON LISP GUIs Through JAVA
## 20.4 Using CAPI to Build Graphical User Interfaces
## 20.5 Using Lisp on Mobile Devices

# 21 Persistence
## 21.1 Serializing Your Data
## 21.2 Accessing Relational Databases
## 21.3 Keeping Your Database in RAM
## 21.4 Using a Lisp Object Database

# 22 The World Outside
## 22.1 Accessing Environment Variables
## 22.2 Accessing the Command-Line Arguments
## 22.3 Querying Your Lisp for Information About Its Environment
## 22.4 Delivering Stand-Alone Executables
## 22.5 Customizing Your Lisp
## 22.6 Running External Programs
## 22.7 Embedding Lisp
## 22.8 Measuring Time
## 22.9 Working with Dates and Times
## 22.10 Working with the Garbage Collector

