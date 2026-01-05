# Clojure Cookbook
* https://www.oreilly.com/library/view/clojure-cookbook/9781449366384/

# 1. Primitive Data/原始数据
- 1.1. Changing the Capitalization of a String
- 1.2. Cleaning Up Whitespace in a String
- 1.3. Building a String from Parts
- 1.4. Treating a String as a Sequence of Characters
- 1.5. Converting Between Characters and Integers
- 1.6. Formatting Strings
- 1.7. Searching a String by Pattern
- 1.8. Pulling Values Out of a String Using Regular Expressions
- 1.9. Performing Find and Replace on Strings
- 1.10. Splitting a String into Parts
- 1.11. Pluralizing Strings Based on a Quantity
- 1.12. Converting Between Strings, Symbols, and Keywords
- 1.13. Maintaining Accuracy with Extremely Large/Small Numbers
- 1.14. Working with Rational Numbers
- 1.15. Parsing Numbers
- 1.16. Truncating and Rounding Numbers
- 1.17. Performing Fuzzy Comparison
- 1.18. Performing Trigonometry
- 1.19. Inputting and Outputting Integers with Different Bases
- 1.20. Calculating Statistics on Collections of Numbers
- 1.21. Performing Bitwise Operations
- 1.22. Generating Random Numbers
- 1.23. Working with Currency
- 1.24. Generating Unique IDs
- 1.25. Obtaining the Current Date and Time
- 1.26. Representing Dates as Literals
- 1.27. Parsing Dates and Times Using clj-time
- 1.28. Formatting Dates Using clj-time
- 1.29. Comparing Dates
- 1.30. Calculating the Length of a Time Interval
- 1.31. Generating Ranges of Dates and Times
- 1.32. Generating Ranges of Dates and Times Using Native Java Types
- 1.33. Retrieving Dates Relative to One Another
- 1.34. Working with Time Zones
- 1.35. Converting a Unix Timestamp to a Date
- 1.36. Converting a Date to a Unix Timestamp

# 2. Composite Data/聚合数据
- 2.1. Creating a List
- 2.2. Creating a List from an Existing Data Structure
- 2.3. “Adding” an Item to a List
- 2.4. “Removing” an Item from a List
- 2.5. Testing for a List
- 2.6. Creating a Vector
- 2.7. “Adding” an Item to a Vector
- 2.8. “Removing” an Item from a Vector
- 2.9. Getting the Value at an Index
- 2.10. Setting the Value at an Index
- 2.11. Creating a Set
- 2.12. Adding and Removing Items from Sets
- 2.13. Testing Set Membership
- 2.14. Using Set Operations
- 2.15. Creating a Map
- 2.16. Retrieving Values from a Map
- 2.17. Retrieving Multiple Keys from a Map Simultaneously
- 2.18. Setting Keys in a Map
- 2.19. Using Composite Values as Map Keys
- 2.20. Treating Maps as Sequences (and Vice Versa)
- 2.21. Applying Functions to Maps
- 2.22. Keeping Multiple Values for a Key
- 2.23. Combining Maps
- 2.24. Comparing and Sorting Values
- 2.25. Removing Duplicate Elements from a Collection
- 2.26. Determining if a Collection Holds One of Several Values
- 2.27. Implementing Custom Data Structures: Red-Black Trees—Part I
- 2.28. Implementing Custom Data Structures: Red-Black Trees—Part II

# 3. General Computing/通用计算
- 3.1. Running a Minimal Clojure REPL
- 3.2. Interactive Documentation
- 3.3. Exploring Namespaces
- 3.4. Trying a Library Without Explicit Dependencies
- 3.5. Running Clojure Programs
- 3.6. Running Programs from the Command Line
- 3.7. Parsing Command-Line Arguments
- 3.8. Creating Custom Project Templates
- 3.9. Building Functions with Polymorphic Behavior
- 3.10. Extending a Built-In Type
- 3.11. Decoupling Consumers and Producers with core.async
- 3.12. Making a Parser for Clojure Expressions Using core.match
- 3.13. Querying Hierarchical Graphs with core.logic
- 3.14. Playing a Nursery Rhyme

# 4. Local I/O/本地IO
- 4.1. Writing to STDOUT and STDERR
- 4.2. Reading a Single Keystroke from the Console
- 4.3. Executing System Commands
- 4.4. Accessing Resource Files
- 4.5. Copying Files
- 4.6. Deleting Files or Directories
- 4.7. Listing Files in a Directory
- 4.8. Memory Mapping a File
- 4.9. Reading and Writing Text Files
- 4.10. Using Temporary Files
- 4.11. Reading and Writing Files at Arbitrary Positions
- 4.12. Parallelizing File Processing
- 4.13. Parallelizing File Processing with Reducers
- 4.14. Reading and Writing Clojure Data
- 4.15. Using edn for Configuration Files
- 4.16. Emitting Records as edn Values
- 4.17. Handling Unknown Tagged Literals When Reading Clojure Data
- 4.18. Reading Properties from a File
- 4.19. Reading and Writing Binary Files
- 4.20. Reading and Writing CSV Data
- 4.21. Reading and Writing Compressed Files
- 4.22. Working with XML Data
- 4.23. Reading and Writing JSON Data
- 4.24. Generating PDF Files
- 4.25. Making a GUI Window with Scrollable Text

# 5. Network I/O and Web Services/网络IO和Web服务
- 5.1. Making HTTP Requests
- 5.2. Performing Asynchronous HTTP Requests
- 5.3. Sending a Ping Request
- 5.4. Retrieving and Parsing RSS Data
- 5.5. Sending Email
- 5.6. Communicating over Queues Using RabbitMQ
- 5.7. Communicating with Embedded Devices via MQTT
- 5.8. Using ZeroMQ Concurrently
- 5.9. Creating a TCP Client
- 5.10. Creating a TCP Server
- 5.11. Sending and Receiving UDP Packets

# 6. Databases/数据库
- 6.1. Connecting to an SQL Database
- 6.2. Connecting to an SQL Database with a Connection Pool
- 6.3. Manipulating an SQL Database
- 6.4. Simplifying SQL with Korma
- 6.5. Performing Full-Text Search with Lucene
- 6.6. Indexing Data with ElasticSearch
- 6.7. Working with Cassandra
- 6.8. Working with MongoDB
- 6.9. Working with Redis
- 6.10. Connecting to a Datomic Database
- 6.11. Defining a Schema for a Datomic Database
- 6.12. Writing Data to Datomic
- 6.13. Removing Data from a Datomic Database
- 6.14. Trying Datomic Transactions Without Committing Them
- 6.15. Traversing Datomic Indexes

# 7. Web Applications/Web应用
- 7.1. Introduction to Ring
- 7.2. Using Ring Middleware
- 7.3. Serving Static Files with Ring
- 7.4. Handling Form Data with Ring
- 7.5. Handling Cookies with Ring
- 7.6. Storing Sessions with Ring
- 7.7. Reading and Writing Request and Response Headers in Ring
- 7.8. Routing Requests with Compojure
- 7.9. Performing HTTP Redirects with Ring
- 7.10. Building a RESTful Application with Liberator
- 7.11. Templating HTML with Enlive
- 7.12. Templating with Selmer
- 7.13. Templating with Hiccup
- 7.14. Rendering Markdown Documents
- 7.15. Building Applications with Luminus

# 8. Performance and Production/性能和生产
- 8.1. AOT Compilation
- 8.2. Packaging a Project into a JAR File
- 8.3. Creating a WAR File
- 8.4. Running an Application as a Daemon
- 8.5. Alleviating Performance Problems with Type Hinting
- 8.6. Fast Math with Primitive Java Arrays
- 8.7. Simple Profiling with Timbre
- 8.8. Logging with Timbre
- 8.9. Releasing a Library to Clojars
- 8.10. Using Macros to Simplify API Deprecations

# 9. Distributed Computation/分布式计算
- 9.1. Building an Activity Feed System with Storm
- 9.2. Processing Data with an Extract Transform Load (ETL) Pipeline
- 9.3. Aggregating Large Files
- 9.4. Testing Cascalog Workflows
- 9.5. Checkpointing Cascalog Jobs
- 9.6. Explaining a Cascalog Query
- 9.7. Running a Cascalog Job on Elastic MapReduce

# 10. Testing/测试
- 10.1. Unit Testing
- 10.2. Testing with Midje
- 10.3. Thoroughly Testing by Randomizing Inputs
- 10.4. Finding Values That Cause Failure
- 10.5. Running Browser-Based Tests
- 10.6. Tracing Code Execution
- 10.7. Avoiding Null-Pointer Exceptions with core.typed
- 10.8. Verifying Java Interop Using core.typed
- 10.9. Type Checking Higher-Order Functions with core.typed
