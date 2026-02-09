# Clojure RTFSC
* https://github.com/clojure/clojure

version: 1.12.4.

author: Rich Hickey

# Deps
- the ASM bytecode engineering library
- the Guava Murmur3 hash implementation

# src/clj/clojure


terms
- `assoc`: `(assoc map key val & kvs)` 'assoc[iate]'. 
  - When applied to a map, returns a new map of the same (hashed/sorted) type, that contains the mapping of key(s) to val(s). 
  - When applied to a vector, returns a new vector that contains val at index.
- `conj`: `(conj coll x & xs)`, 'conj[oin]'. Returns a new collection with the xs 'added'.
- `cons`: `(cons x seq)`, Returns a new seq where x is the first element and seq is the rest.
- `disj`: `(disj set key & ks)` 'disj[oin]'. Returns a new set of the same (hashed/sorted) type, that does not contain key(s).
- `dissoc`: `(dissoc map key & ks)` 'dissoc[iate]'. Returns a new map of the same (hashed/sorted) type, that does not contain a mapping for key(s).


```shell
|-- core
|   |-- protocols.clj                    ; reduce protocols
|   |-- reducers.clj
|   `-- server.clj                       ; Socket server support
|-- core.clj
|-- core_deftype.clj                     ; definterface, reify/deftype, protocols: (in-ns 'clojure.core)
|-- core_print.clj                       ; printing: (in-ns 'clojure.core)
|-- core_proxy.clj                       ; proxy: (in-ns 'clojure.core)
|-- data.clj
|-- datafy.clj
|-- edn.clj
|-- genclass.clj                         ; gen-class: (in-ns 'clojure.core)
|-- gvec.clj                             ; a generic vector implementation for vectors of primitives: (in-ns 'clojure.core)
|-- inspector.clj
|-- instant.clj
|-- java
|   |-- basis
|   |   `-- impl.clj
|   |-- basis.clj
|   |-- browse.clj
|   |-- browse_ui.clj
|   |-- io.clj
|   |-- javadoc.clj
|   |-- process.clj
|   `-- shell.clj
|-- main.clj                             ; Top-level main function for Clojure REPL and scripts
|-- math.clj
|-- parallel.clj
|-- pprint
|   |-- cl_format.clj
|   |-- column_writer.clj                ; 
|   |-- dispatch.clj
|   |-- pprint_base.clj
|   |-- pretty_writer.clj
|   |-- print_table.clj
|   `-- utilities.clj
|-- pprint.clj
|-- reflect
|   `-- java.clj
|-- reflect.clj
|-- repl
|   `-- deps.clj
|-- repl.clj                             ; Utilities meant to be used interactively at the REPL
|-- set.clj
|-- stacktrace.clj
|-- string.clj
|-- template.clj
|-- test
|   |-- junit.clj
|   `-- tap.clj
|-- test.clj
|-- tools
|   `-- deps
|       `-- interop.clj
|-- uuid.clj
|-- walk.clj
|-- xml.clj
`-- zip.clj
```

# src/jvm/clojure

- `IXxx`: interface
- `AXxx`: abstract class

```shell
|-- asm                                // ASM
|   `-- commons
|       |-- GeneratorAdapter.java
|       |-- LocalVariablesSorter.java
|       |-- Method.java
|       `-- TableSwitchGenerator.java
|   |-- AnnotationVisitor.java
|   |-- AnnotationWriter.java
|   |-- Attribute.java
|   |-- ByteVector.java
|   |-- ClassReader.java
|   |-- ClassVisitor.java
|   |-- ClassWriter.java
|   |-- ConstantDynamic.java
|   |-- Constants.java
|   |-- Context.java
|   |-- CurrentFrame.java
|   |-- Edge.java
|   |-- FieldVisitor.java
|   |-- FieldWriter.java
|   |-- Frame.java
|   |-- Handle.java
|   |-- Handler.java
|   |-- Label.java
|   |-- MethodVisitor.java
|   |-- MethodWriter.java
|   |-- ModuleVisitor.java
|   |-- ModuleWriter.java
|   |-- Opcodes.java
|   |-- Symbol.java
|   |-- SymbolTable.java
|   |-- Type.java
|   |-- TypePath.java
|   |-- TypeReference.java
|-- java
|   `-- api
|       |-- Clojure.java                 // The Clojure class provides a minimal interface to bootstrap Clojure access from other JVM languages.
|       `-- package.html
|-- lang
|   |-- AFn.java                         // abstract function
|   |-- AFunction.java                   // abstract function with methodImplCache
|   |-- Agent.java                       // agent <---
|   |-- AMapEntry.java                   // abstract map entry
|   |-- APersistentMap.java              // abstract persistent map
|   |-- APersistentSet.java              // abstract persistent set
|   |-- APersistentVector.java           // abstract persistent vector
|   |-- ARef.java                        // abstract reference with validator and watches
|   |-- AReference.java                  // abstract reference with meta
|   |-- ArityException.java              // illegal arity exception
|   |-- ArrayChunk.java                  // array chunk
|   |-- ArrayIter.java                   // array iterator
|   |-- ArraySeq.java                    // array sequence
|   |-- ASeq.java                        // abstract sequence
|   |-- Associative.java                 // assoc iterface: containsKey, entryAt, assoc
|   |-- Atom.java                        // atom <---
|   |-- ATransientMap.java               // abstract teansient map
|   |-- ATransientSet.java               // abstract teansient set
|   |-- BigInt.java                      // long, BigInteger
|   |-- Binding.java                     // binding
|   |-- Box.java                         // boxed value
|   |-- ChunkBuffer.java                 // chunk buffer
|   |-- ChunkedCons.java                 // chunked cons
|   |-- Compile.java                     // Compiles libs and generates class files stored within the directory named by the Java System property "clojure.compile.path"
|   |-- Compiler.java                    // eval
|   |-- Cons.java                        // cons
|   |-- Counted.java                     // A class that implements Counted promises that it is a collection that implement a constant-time count()    
|   |-- Cycle.java                       // cycle
|   |-- Delay.java                       // delay
|   |-- DynamicClassLoader.java          // dynamic class loader
|   |-- EdnReader.java                   // edn reader
|   |-- EnumerationSeq.java              // enum sequence
|   |-- ExceptionInfo.java               // Interface for exceptions that carry data (a map) as additional payload.
|   |-- Fn.java                          // marker interface: function
|   |-- FnInvokers.java                  // function invoker
|   |-- FnLoaderThunk.java               // function loader thunk
|   |-- IAtom.java                       // swap, compareAndSet, reset
|   |-- IAtom2.java                      // swapVals, resetVals
|   |-- IBlockingDeref.java              // deref
|   |-- IChunk.java                      // dropFirst, reduce
|   |-- IChunkedSeq.java                 // chunkedFirst, chunkedNext, chunkedMore
|   |-- IDeref.java                      // dereference: deref
|   |-- IDrop.java                       // drop
|   |-- IEditableCollection.java         // asTransient
|   |-- IExceptionInfo.java              // Interface for exceptions that carry data (a map) as additional payload. <---
|   |-- IFn.java                         // IFn provides complete access to invoking any of Clojure's APIs
|   |-- IHashEq.java                     // hasheq
|   |-- IKeywordLookup.java              // getLookupThunk
|   |-- IKVReduce.java                   // kvreduce
|   |-- ILookup.java                     // valAt
|   |-- ILookupSite.java                 // lookup site: fault
|   |-- ILookupThunk.java                // lookup thunk: get
|   |-- IMapEntry.java                   // map entry
|   |-- IMapIterable.java                // keyIterator, valIterator
|   |-- IMeta.java                       // meta
|   |-- Indexed.java                     // nth
|   |-- IndexedSeq.java                  // index
|   |-- Intrinsics.java                  // ops, preds
|   |-- IObj.java                        // withMeta
|   |-- IPending.java                    // isRealized
|   |-- IPersistentCollection.java       // persistent collection
|   |-- IPersistentList.java             // persistent list
|   |-- IPersistentMap.java              // persistent map
|   |-- IPersistentSet.java              // persistent set
|   |-- IPersistentStack.java            // persistent stack
|   |-- IPersistentVector.java           // persistent vector
|   |-- IProxy.java                      // ClojureFnMappings
|   |-- IRecord.java                     // marker interface: record <---
|   |-- IReduce.java                     // reduce
|   |-- IReduceInit.java                 // reduce with start
|   |-- IRef.java                        // reference: validator, watch
|   |-- IReference.java                  // reference
|   |-- ISeq.java                        // A persistent, functional, sequence interface: first, next, more, cons
|   |-- Iterate.java                     // sequence interate
|   |-- IteratorSeq.java                 // sequence iterator
|   |-- ITransientAssociative.java       // transient assoc
|   |-- ITransientAssociative2.java      // ITransientAssociative with containsKey, entryAt
|   |-- ITransientCollection.java        // transient collection: conj
|   |-- ITransientMap.java               // transient map: assoc, without
|   |-- ITransientSet.java               // transient set: disjoin, contains, get
|   |-- ITransientVector.java            // transient vector: assocN, pop
|   |-- IType.java                       // marker interface: type
|   |-- Keyword.java                     // keyword <---
|   |-- KeywordLookupSite.java           // keyword lookup site
|   |-- LazilyPersistentVector.java      // lazy persitent vector
|   |-- LazySeq.java                     // lazy sequence
|   |-- LineNumberingPushbackReader.java // PushbackReader + LineNumberReader
|   |-- LispReader.java                  // Lisp reader: macros, dispatch macros, read
|   |-- LockingTransaction.java          // transaction using lock
|   |-- LongRange.java                   // a finite range based on long start, end, and step
|   |-- MapEntry.java                    // map entry: key, val
|   |-- MapEquivalence.java              // marker interface: map equal
|   |-- MethodImplCache.java             // method implementation cache
|   |-- MultiFn.java                     // multimethod <---
|   |-- Murmur3.java                     // http://smhasher.googlecode.com/svn/trunk/MurmurHash3.cpp
|   |-- Named.java                       // getNamespace, getName
|   |-- Namespace.java                   // namespace <---
|   |-- Numbers.java                     // number ops
|   |-- Obj.java                         // clojure object <---
|   |-- PersistentArrayMap.java          // Simple implementation of persistent map on an array
|   |-- PersistentHashMap.java           // A persistent rendition of Phil Bagwell's Hash Array Mapped Trie
|   |-- PersistentHashSet.java           // persistent hash set
|   |-- PersistentList.java              // persistent list
|   |-- PersistentQueue.java             // persistent queue
|   |-- PersistentStructMap.java         // persistent struct map: obsolete style `defstruct`, `create-struct`, `struct-map`
|   |-- PersistentTreeMap.java           // Persistent Red Black Tree
|   |-- PersistentTreeSet.java           // persistent tree set
|   |-- PersistentVector.java            // persistent vector
|   |-- ProxyHandler.java                // InvocationHandler: method-name-string->fn
|   |-- Range.java                       // Implements generic numeric (potentially infinite) range
|   |-- Ratio.java                       // ratio number
|   |-- ReaderConditional.java           // reader conditionals
|   |-- RecordIterator.java              // record iterator
|   |-- Reduced.java                     // deref val
|   |-- Ref.java                         // reference <---
|   |-- Reflector.java                   // Java reflection util
|   |-- Repeat.java                      // repeat
|   |-- Repl.java                        // main.legacy_repl
|   |-- RestFn.java                      // getRequiredArity
|   |-- Reversible.java                  // rseqs
|   |-- RT.java                          // runtime
|   |-- Script.java                      // main.legacy_script
|   |-- Seqable.java                     // ISeq seq();
|   |-- SeqEnumeration.java              // sequence enum
|   |-- SeqIterator.java                 // sequence iterator
|   |-- Sequential.java                  // marker interface: sequential
|   |-- Settable.java                    // doSet, doReset
|   |-- Sorted.java                      // sort interface
|   |-- StringSeq.java                   // string sequence
|   |-- Symbol.java                      // symbol <---
|   |-- TaggedLiteral.java               // symbol tagged literal
|   |-- TransactionalHashMap.java        // transactional hash map
|   |-- TransformerIterator.java         // transformer iterator
|   |-- Tuple.java                       // vector with max size 6
|   |-- Util.java                        // util
|   |-- Var.java                         // var <---
|   |-- Volatile.java                    // volatile deref
|   |-- WarnBoxedMath.java               // boxed math annotation
|   |-- XMLHandler.java                  // SAX XML handler
|   `-- package.html
`-- main.java
```

## Compiler.java

```shell
AssignableExpr
|-- InstanceFieldExpr
|-- LocalBindingExpr
|-- StaticFieldExpr
|-- VarExpr

Expr
|-- AssignExpr
|-- DefExpr
|-- EmptyExpr
|-- ImportExpr
|-- InvokeExpr
|-- KeywordInvokeExpr
|-- LetFnExpr
|-- ListExpr
|-- LiteralExpr 
|  |-- KeywordExpr 
|  |-- NumberExpr
|  |-- ConstantExpr
|  |-- NilExpr
|  |-- BooleanExpr
|  |-- StringExpr
|-- MaybePrimitiveExpr
|  |-- BodyExpr
|  |-- CaseExpr
|  |-- HostExpr 
|  |  |-- FieldExpr 
|  |  |  |-- InstanceFieldExpr
|  |  |  |-- StaticFieldExpr
|  |  |-- MethodExpr 
|  |  |  |-- InstanceMethodExpr
|  |  |  |-- StaticMethodExpr
|  |-- IfExpr 
|  |-- InstanceOfExpr
|  |-- LetExpr
|  |-- LocalBindingExpr
|  |-- MethodParamExpr
|  |-- NumberExpr
|  |-- RecurExpr
|  |-- StaticInvokeExpr
|-- MapExpr
|-- MetaExpr
|-- NewExpr
|-- ObjExpr
|  |-- FnExpr
|  |-- NewInstanceExpr
|-- QualifiedMethodExpr
|-- SetExpr
|-- TheVarExpr
|-- TryExpr
|-- UnresolvedVarExpr
|-- UntypedExpr
|  |-- MonitorEnterExpr
|  |-- MonitorExitExpr
|  |-- ThrowExpr
|-- VarExpr
|-- VectorExpr
```

## LispReader.java


# TODO
- `&form`, `&env` in macros