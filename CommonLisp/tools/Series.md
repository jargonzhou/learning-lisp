# Series
* https://series.sourceforge.net/
* [Common Lisp the Language, 2nd Edition - Appendix A. Series](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node347.html)

> Richard C. Waters' `SERIES` package for Common Lisp.

A series is a data structure much like a sequence, with similar kinds of operations. 
The difference is that in many situations, operations on series may be composed functionally and yet execute iteratively, without the need to construct intermediate series values explicitly. 
In this manner, series provide both the clarity of a functional programming style and the efficiency of an iterative programming style.

# Series Functions

The `#` macro character syntax `#Zlist` denotes a series/系列 that contains the elements of list. This syntax is also used when series are printed.
```lisp
(choose-if #'symbolp #Z(a 2 b)) => #Z(a b)
```

```lisp
;;; [Type specifier]
series element-type
;;; [Function]
series arg &rest args
```

## Scanners/扫描器
Scanners create series outputs based on non-series inputs. Either they operate based on some formula (for example, scanning a range of integers) or they enumerate the elements in an aggregate data structure (for example, scanning the elements in a list or array).

```lisp
;;; [Function]
scan-range &key (:start 0) (:by 1) (:type 'number):upto :below :downto :above :length
;;; [Function]
scan sequence
scan type sequence
;;; [Function]
scan-sublists list
;;; [Function]
scan-multiple type first-sequence &rest more-sequences
;;; [Function]
scan-lists-of-lists lists-of-lists &optional leaf-test
scan-lists-of-lists-fringe lists-of-lists &optional leaf-test
;;; [Function]
scan-alist a-list &optional (test #'eql)
scan-plist plist
scan-hash table
;;; [Function]
scan-symbols &optional (package *package*)
;;; [Function]
scan-file file-name &optional (reader #'read)
;;; [Function]
scan-fn type init step &optional test
;;; [Function]
scan-fn-inclusive type init step test
```

## Mapping
By far the most common kind of series operation is mapping. In cognizance of this fact, four different ways are provided for specifying mapping: one fundamental form (`map-fn`) and three shorthand forms that are more convenient in particular common situations.

```lisp
;;; [Function]
map-fn type function &rest series-inputs
;;; [Macro]
mapping ({({var | ({var}*)} value)}*) {declaration}* {form}*
;;; [Macro]
iterate ({({var | ({var}*)} value)}*) {declaration}* {form}*
```

The `#` macro character syntax `#M` makes it easy to specify uses of map-fn where `type` is `t` and the `function` is a named function. The notation `(#Mfunction ...)` is an abbreviation for `(map-fn t #'function ...)`.

## Truncation and Other Simple Transducers/截断和其他简单转换器
Transducers compute series from series and form the heart of most series expressions. Mapping is by far the most common transducer. This section presents a number of additional simple transducers.

```lisp
;;; [Function]
cotruncate &rest series-inputs
until bools &rest series-inputs
until-if pred &rest series-inputs
;;; [Function]
previous items &optional (default nil) (amount 1)
;;; [Function]
latch items &key :after :before :pre :post
;;; [Function]
collecting-fn type init function &rest series-inputs
```

## Conditional and Other Complex Transducers/条件和其他复杂转换器
This section presents a number of complex transducers, including ones that support conditional computation.

```lisp
;;; [Function]
choose bools &optional (items bools)
choose-if pred items
;;; [Function]
expand bools items &optional (default nil)
;;; [Function]
split items &rest test-series-inputs
split-if items &rest test-predicates
;;; [Function]
catenate &rest series-inputs
;;; [Function]
subseries items start &optional below
;;; [Function]
positions bools
;;; [Function]
mask monotonic-indices
;;; [Function]
mingle items1 items2 comparator
;;; [Function]
chunk m n items
```

## Collectors/收集器
Collectors produce non-series outputs based on series inputs. They either create a summary value based on some formula (the sum, for example) or collect the elements of a series in an aggregate data structure (such as a list).

```lisp
;;; [Function]
collect-first items &optional (default nil)
collect-last items &optional (default nil)
collect-nth n items &optional (default nil)
;;; [Function]
collect-length items
;;; [Function]
collect-sum numbers &optional (type 'number)
;;; [Function]
collect-max numbers
collect-min numbers
;;; [Function]
collect-and bools
;;; [Function]
collect-or bools
;;; [Function]
collect items
collect type items
;;; [Function]
collect-append sequences
collect-append type sequences
;;; [Function]
collect-nconc lists
;;; [Function]
collect-alist keys values
collect-plist keys values
collect-hash keys values &key :test :size :rehash-size :rehash-threshold
;;; [Function]
collect-file file-name items &optional (printer #'print)
;;; [Function]
collect-fn type init function &rest series-inputs
```

## Alteration of Series/系列的修改
Series that come from scanning data structures such as lists and vectors are closely linked to these structures. The function `alter` can be used to modify the underlying data structure with reference to the series derived from it.

```lisp
;;; [Function]
alter destinations items
;;; [Function]
to-alter items alter-fn &rest args
```


# See Also
