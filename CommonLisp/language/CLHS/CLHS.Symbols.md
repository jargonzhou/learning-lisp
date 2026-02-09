# CLSH Symbols

There are 978 symbols in the `COMMON-LISP` package.

# Scope

- Ordinary Lambda Lists
- Macro Lambda Lists
- Evaluation and Compilation
- Types and Classes
- Data and Control Flow
- Iteration
- Objects
- Structures
- Conditions
- Symbols
- Packages
- Numbers
- Characters
- Conses
- Arrays
- Strings
- Sequences
- Hash Tables
- Filenames
- Files
- Streams
- Printer
- Reader
- System
- Environment


# 1. `&allow-other-keys` `Ordinary Lambda Lists`
# 2. `&aux` `Ordinary Lambda Lists`
# 3. `&body` `Macro Lambda Lists`
# 4. `&environment` `Macro Lambda Lists`
# 5. `&key` `Ordinary Lambda Lists`
# 6. `&optional` `Ordinary Lambda Lists`
# 7. `&rest` `Ordinary Lambda Lists`
# 8. `&whole` `Ordinary Lambda Lists`
# 9. `*` `Environment` `Numbers`

`*, **, ***`

**Value Type**:
一个对象.

**Initial Value**:
依赖于实现.

**Description**:

变量`*`, `**`和`***`由Lisp REPL维护, 保存每次通过循环打印输出的结果的值.

`*`的值是最近打印的主值, `**`的值是`*`前一个的主值, `***`的值是`**`前一个的主值.

如果产生了多个值, `*`只包含第一个值; 如果没有值产生, `*`的值是nil.

`*`, `**`和`***`的值在Lisp REPL打印一个顶层形式的返回值之前立即更新. 如果该形式的求值在正常返回之前中断, `*`, `**`和`***`的值不被更新.

**Examples**:
```lisp
(values 'a1 'a2) =>  A1, A2
'b =>  B
(values 'c1 'c2 'c3) =>  C1, C2, C3
(list * ** ***) =>  (C1 B A1)

(defun cube-root (x) (expt x 1/3)) =>  CUBE-ROOT
(compile *) =>  CUBE-ROOT
(setq a (cube-root 27.0)) =>  3.0
(* * 9.0) =>  27.0
```

**Affected By**:
Lisp REPL.

**Exceptional Situations**:

**See Also**:
-, +, /, 25.1.1 顶层循环

**Notes**:
```
 *   ==  (car /)
 **  ==  (car //)
 *** ==  (car ///)
```

# 10. `**` `Environment`
# 11. `***` `Environment`
# 12. `*break-on-signals*` `Conditions`
# 13. `*compile-file-pathname*` `System`
# 14. `*compile-file-truename*` `System`
# 15. `*compile-print*` `System`
# 16. `*compile-verbose*` `System`
# 17. `*debug-io*` `Streams`
# 18. `*debugger-hook*` `Conditions`
# 19. `*default-pathname-defaults*` `Filenames`
# 20. `*error-output*` `Streams`
# 21. `*features*` `System`
# 22. `*gensym-counter*` `Symbols`
# 23. `*load-pathname*` `System`
# 24. `*load-print*` `System`
# 25. `*load-truename*` `System`
# 26. `*load-verbose*` `System`
# 27. `*macroexpand-hook*` `Evaluation and Compilation`
# 28. `*modules*` `System`
# 29. `*package*` `Packages`
# 30. `*print-array*` `Printer`
# 31. `*print-base*` `Printer`
# 32. `*print-case*` `Printer`
# 33. `*print-circle*` `Printer`
# 34. `*print-escape*` `Printer`
# 35. `*print-gensym*` `Printer`
# 36. `*print-length*` `Printer`
# 37. `*print-level*` `Printer`
# 38. `*print-lines*` `Printer`
# 39. `*print-miser-width*` `Printer`
# 40. `*print-pprint-dispatch*` `Printer`
# 41. `*print-pretty*` `Printer`
# 42. `*print-radix*` `Printer`
# 43. `*print-readably*` `Printer`
# 44. `*print-right-margin*` `Printer`
# 45. `*query-io*` `Streams`
# 46. `*random-state*` `Numbers`
# 47. `*read-base*` `Reader`
# 48. `*read-default-float-format*` `Reader`
# 49. `*read-eval*` `Reader`

**Value Type**:
泛化的布尔值.

**Initital Value**:
`true`

**Description**:
如果为true, `#.`读取器宏正常工作; 否则, `#.`抛出类型为`reader-error`的错误.

**Examples**:
无

**Affected By**:
无

**See Also**:
`*print-readably*`

**Notes**:
如果`*read-eval*`为`false`且`*print-readably*`为`true`, `print-object`的任意需要输出`#.`读取器宏引用的方法可以输出其它内容或抛出类型为`print-not-readabl`e的错误.

# 50. `*read-suppress*` `Reader`
# 51. `*readtable*` `Reader`
# 52. `*standard-input*` `Streams`
# 53. `*standard-output*` `Streams`
# 54. `*terminal-io*` `Streams`
# 55. `*trace-output*` `Streams`
# 56. `+` `Environment` `Numbers`
# 57. `++` `Environment`
# 58. `+++` `Environment`
# 59. `-` `Environment` `Numbers`
# 60. `/` `Environment` `Numbers`
# 61. `//` `Environment`
# 62. `///` `Environment`

`/`, `//`, `///`

**Value Type**:

一个合式列表.

**Initial Value**:

依赖于实现.

**Description**:

变量`/`, `//`和`///`由Lisp REPL维护, 保存每次在循环结束时打印输出的结果的值.

`/`的值是最近打印的值, `//`的值是`/`前一个的值, `///`的值是`//`前一个的值.

`/`, `//`和`///`的值在Lisp REPL打印一个顶层形式的返回值之前立即更新. 如果该形式的求值在正常返回之前中断, `/`, `//`和`///`的值不被更新.

**Examples**:

```
 (floor 22 7) =>  3, 1
 (+ (* (car /) 7) (cadr /)) =>  22
; / means a list (3, 1)
```

**Affected By**:

Lisp REPL.

**See Also**:

-, +, *, 25.1.1 顶层循环

**Notes**:

无

# 63. `/=` `Numbers`
# 64. `1+` `Numbers`
# 65. `1-` `Numbers`
# 66. `<` `Numbers`
# 67. `<=` `Numbers`
# 68. `=` `Numbers`
# 69. `>` `Numbers`
# 70. `>=` `Numbers`
# 71. `abort` `Conditions`
# 72. `abs` `Numbers`
# 73. `acons` `Conses`
# 74. `acos` `Numbers`
# 75. `acosh` `Numbers`
# 76. `add-method` `Objects`
# 77. `adjoin` `Conses`

> "Function"

**Syntax**:

```
adjoin item list &key key test test-not => new-list
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 78. `adjust-array` `Arrays`
# 79. `adjustable-array-p` `Arrays`
# 80. `allocate-instance` `Objects`
# 81. `alpha-char-p` `Characters`
# 82. `alphanumericp` `Characters`
# 83. `and` `Data and Control Flow` `Types and Classes`

**Syntax**:

```
and form* => result*
```

**Arguments and Values**:

- `form`: 一个形式
- `results`: 最后一个`form`的求值结果, 或符号`nil`, 或`t`

**Description**:

宏`and`按 **从左至右** 的顺序一次求值一个`form`. 一旦任意形式求值为`nil`, `and`不再对剩下的`form`求值直接返回`nil`. 如果除最后一个外所有的`form`求值为true, `and`返回求值最后一个`form`的结果.

如果没有提供`form`, `(and)`返回`t`.

`and`可以返回最后一个子形式的多值.

**Examples**:

```
(if (and (>= n 0)
			 (< n (length a-simple-vector))
			 (eq (elt a-simple-vector n) 'foo))
	(princ "Foo!"))
```

如果`a-simple-vector`的`n`位置元素是符号`foo`, `n`对`a-simple-vector`是有效的索引, 则上述表达式输出`Foo!`. 如果`n`越界, 因为`and`保证从左至右的顺序测试其内容部分, `elt`不被调用.

```
(setq temp1 1 temp2 1 temp3 1) =>  1
(and (incf temp1) (incf temp2) (incf temp3)) =>  2
(and (eql 2 temp1) (eql 2 temp2) (eql 2 temp3)) =>  true
(decf temp3) =>  1

; (eq temp3 'nil)求值为false, (decf temp3)不被执行
(and (decf temp1) (decf temp2) (eq temp3 'nil) (decf temp3)) =>  NIL

(and (eql temp1 temp2) (eql temp2 temp3)) =>  true
(and) =>  T
```

**Side Effects**:

**Affected By**:

无

**Exceptional Situations**:

无

**See Also**:

cond, every, if, or, when

**Notes**:

```
(and form) ==  (let () form)
(and form1 form2 ...) ==  (when form1 (and form2 ...))
```

# 84. `append` `Conses`
# 85. `apply` `Data and Control Flow`
# 86. `apropos` `Environment`
# 87. `apropos-list` `Environment`
# 88. `aref` `Arrays`
# 89. `arithmetic-error` `Numbers`
# 90. `arithmetic-error-operands` `Numbers`
# 91. `arithmetic-error-operation` `Numbers`
# 92. `array` `Arrays`
# 93. `array-dimension` `Arrays`
# 94. `array-dimension-limit` `Arrays`
# 95. `array-dimensions` `Arrays`
# 96. `array-displacement` `Arrays`
# 97. `array-element-type` `Arrays`
# 98. `array-has-fill-pointer-p` `Arrays`
# 99. `array-in-bounds-p` `Arrays`
# 100. `array-rank` `Arrays`
# 101. `array-rank-limit` `Arrays`
# 102. `array-row-major-index` `Arrays`
# 103. `array-total-size` `Arrays`
# 104. `array-total-size-limit` `Arrays`
# 105. `arrayp` `Arrays`
# 106. `ash` `Numbers`
# 107. `asin` `Numbers`
# 108. `asinh` `Numbers`
# 109. `assert` `Conditions`
# 110. `assoc` `Conses`
# 111. `assoc-if` `Conses`
# 112. `assoc-if-not` `Conses`
# 113. `atan` `Numbers`
# 114. `atanh` `Numbers`
# 115. `atom` `Conses`

> "Function"

**Syntax**:

```
atom object => generalized-boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 116. `base-char` `Characters`
# 117. `base-string` `Strings`
# 118. `bignum` `Numbers`
# 119. `bit` `Arrays` `Numbers`
# 120. `bit-and` `Arrays`
# 121. `bit-andc1` `Arrays`
# 122. `bit-andc2` `Arrays`
# 123. `bit-eqv` `Arrays`
# 124. `bit-ior` `Arrays`
# 125. `bit-nand` `Arrays`
# 126. `bit-nor` `Arrays`
# 127. `bit-not` `Arrays`
# 128. `bit-orc1` `Arrays`
# 129. `bit-orc2` `Arrays`
# 130. `bit-vector` `Arrays`
# 131. `bit-vector-p` `Arrays`
# 132. `bit-xor` `Arrays`
# 133. `block` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
block name form* => result*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 134. `boole` `Numbers`
# 135. `boole-1` `Numbers`
# 136. `boole-2` `Numbers`
# 137. `boole-and` `Numbers`
# 138. `boole-andc1` `Numbers`
# 139. `boole-andc2` `Numbers`
# 140. `boole-c1` `Numbers`
# 141. `boole-c2` `Numbers`
# 142. `boole-clr` `Numbers`
# 143. `boole-eqv` `Numbers`
# 144. `boole-ior` `Numbers`
# 145. `boole-nand` `Numbers`
# 146. `boole-nor` `Numbers`
# 147. `boole-orc1` `Numbers`
# 148. `boole-orc2` `Numbers`
# 149. `boole-set` `Numbers`
# 150. `boole-xor` `Numbers`
# 151. `boolean` `Types and Classes`
# 152. `both-case-p` `Characters`
# 153. `boundp` `Symbols`
# 154. `break` `Conditions`
# 155. `broadcast-stream` `Streams`
# 156. `broadcast-stream-streams` `Streams`
# 157. `built-in-class` `Types and Classes`
# 158. `butlast` `Conses`
# 159. `byte` `Numbers`
# 160. `byte-position` `Numbers`
# 161. `byte-size` `Numbers`
# 162. `caaaar` `Conses`
# 163. `caaadr` `Conses`
# 164. `caaar` `Conses`
# 165. `caadar` `Conses`
# 166. `caaddr` `Conses`
# 167. `caadr` `Conses`
# 168. `caar` `Conses`
# 169. `cadaar` `Conses`
# 170. `cadadr` `Conses`
# 171. `cadar` `Conses`
# 172. `caddar` `Conses`
# 173. `cadddr` `Conses`
# 174. `caddr` `Conses`
# 175. `cadr` `Conses`
# 176. `call-arguments-limit` `Data and Control Flow`
# 177. `call-method` `Objects`
# 178. `call-next-method` `Objects`
# 179. `car` `Conses`
# 180. `case` `Data and Control Flow`
# 181. `catch` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
catch tag form* => result*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 182. `ccase` `Data and Control Flow`
# 183. `cdaaar` `Conses`
# 184. `cdaadr` `Conses`
# 185. `cdaar` `Conses`
# 186. `cdadar` `Conses`
# 187. `cdaddr` `Conses`
# 188. `cdadr` `Conses`
# 189. `cdar` `Conses`
# 190. `cddaar` `Conses`
# 191. `cddadr` `Conses`
# 192. `cddar` `Conses`
# 193. `cdddar` `Conses`
# 194. `cddddr` `Conses`
# 195. `cdddr` `Conses`
# 196. `cddr` `Conses`
# 197. `cdr` `Conses`

> "Accessor"

**Syntax**:

```
car x => object
cdr x => object
caar x => object
cadr x => object
cdar x => object
cddr x => object
caaar x => object
caadr x => object
cadar x => object
caddr x => object
cdaar x => object
cdadr x => object
cddar x => object
cdddr x => object
caaaar x => object
caaadr x => object
caadar x => object
caaddr x => object
cadaar x => object
cadadr x => object
caddar x => object
cadddr x => object
cdaaar x => object
cdaadr x => object
cdadar x => object
cdaddr x => object
cddaar x => object
cddadr x => object
cdddar x => object
cddddr x => object
(setf (car x) new-object)
(setf (cdr x) new-object)
(setf (caar x) new-object)
(setf (cadr x) new-object)
(setf (cdar x) new-object)
(setf (cddr x) new-object)
(setf (caaar x) new-object)
(setf (caadr x) new-object)
(setf (cadar x) new-object)
(setf (caddr x) new-object)
(setf (cdaar x) new-object)
(setf (cdadr x) new-object)
(setf (cddar x) new-object)
(setf (cdddr x) new-object)
(setf (caaaar x) new-object)
(setf (caaadr x) new-object)
(setf (caadar x) new-object)
(setf (caaddr x) new-object)
(setf (cadaar x) new-object)
(setf (cadadr x) new-object)
(setf (caddar x) new-object)
(setf (cadddr x) new-object)
(setf (cdaaar x) new-object)
(setf (cdaadr x) new-object)
(setf (cdadar x) new-object)
(setf (cdaddr x) new-object)
(setf (cddaar x) new-object)
(setf (cddadr x) new-object)
(setf (cdddar x) new-object)
(setf (cddddr x) new-object)
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 198. `ceiling` `Numbers`
# 199. `cell-error` `Conditions`
# 200. `cell-error-name` `Conditions`
# 201. `cerror` `Conditions`
# 202. `change-class` `Objects`
# 203. `char` `Strings`
# 204. `char-code` `Characters`
# 205. `char-code-limit` `Characters`
# 206. `char-downcase` `Characters`
# 207. `char-equal` `Characters`
# 208. `char-greaterp` `Characters`
# 209. `char-int` `Characters`
# 210. `char-lessp` `Characters`
# 211. `char-name` `Characters`
# 212. `char-not-equal` `Characters`
# 213. `char-not-greaterp` `Characters`
# 214. `char-not-lessp` `Characters`
# 215. `char-upcase` `Characters`
# 216. `char/=` `Characters`
# 217. `char<` `Characters`
# 218. `char<=` `Characters`
# 219. `char=` `Characters`
# 220. `char>` `Characters`
# 221. `char>=` `Characters`
# 222. `character` `Characters`
# 223. `characterp` `Characters`
# 224. `check-type` `Conditions`
# 225. `cis` `Numbers`
# 226. `class` `Types and Classes`
# 227. `class-name` `Objects`
# 228. `class-of` `Objects`
# 229. `clear-input` `Streams`
# 230. `clear-output` `Streams`
# 231. `close` `Streams`
# 232. `clrhash` `Hash Tables`
# 233. `code-char` `Characters`
# 234. `coerce` `Types and Classes`
# 235. `compilation-speed`: 见`optimize`.
# 236. `compile` `Evaluation and Compilation`
# 237. `compile-file` `System`
# 238. `compile-file-pathname` `System`
# 239. `compiled-function` `Types and Classes`
# 240. `compiled-function-p` `Data and Control Flow`
# 241. `compiler-macro`: 见`documentation`.
# 242. `compiler-macro-function` `Evaluation and Compilation`
# 243. `complement` `Data and Control Flow`
# 244. `complex` `Numbers`
# 245. `complexp` `Numbers`
# 246. `compute-applicable-methods` `Objects`
# 247. `compute-restarts` `Conditions`
# 248. `concatenate` `Sequences`
# 249. `concatenated-stream` `Streams`
# 250. `concatenated-stream-streams` `Streams`
# 251. `cond` `Data and Control Flow`

> "Macro"

**Syntax**:

```
cond {clause}* => result*

clause::= (test-form form*)
```

**Arguments and Values**:

- `test-form`: 一个形式
- `forms`: 隐式的`progn`
- `results`: (1) 首个`test-form`为true的`clause`的`forms`的值, 或者(2) 该`clause`中没有`forms`时`test-form`的主值, 或者(3) 没有`test-form`为true时为`nil`

**Description**:

`cond`允许依赖于`test-form`执行`forms`.

`test-form`按参数列表中顺序依次求值, 直到有一个求值为true. 如果在这个子句中没有`forms`, 则`test-form`的 **主值** 作为`cond`形式的结果返回; 否则与该`test-form`相应的`forms`从左至右依次求值, 像在一个隐式的`progn`中一样, 最后一个形式的值作为`cond`形式的返回值.

一旦有一个`test-form`求值为true, 后续的`test-from`不再求值. 如果没有`test-form`求值为true, 则返回`nil`.

**Examples**:

```
(defun select-options ()
(cond ((= a 1) (setq a 2))
			((= a 2) (setq a 3))
			((and (= a 3) (floor a 2)))
			(t (floor a 3)))) =>  SELECT-OPTIONS

(setq a 1) =>  1

(select-options) =>  2 ; ((= a 1) (setq a 2))
a =>  2

(select-options) =>  3 ; ((= a 2) (setq a 3))
a =>  3

(select-options) =>  1 ; ((and (= a 3) (floor a 2)))

(setq a 5) =>  5
(select-options) =>  1, 2 ; (t (floor a 3))
```

**Side Effects**: 无.

**Affected By**: 无.

**Exceptional Situations**: 无.

**See Also**:

if, case

**Notes**: 无.

# 252. `condition` `Conditions`
# 253. `conjugate` `Numbers`
# 254. `cons` `Conses`

> "Function"

**Syntax**:

```
cons object-1 object-2 => cons
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 255. `consp` `Conses`

> "Function"

**Syntax**:

```
consp object => generalized-boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 256. `constantly` `Data and Control Flow`
# 257. `constantp` `Evaluation and Compilation`
# 258. `continue` `Conditions`
# 259. `control-error` `Data and Control Flow`
# 260. `copy-alist` `Conses`
# 261. `copy-list` `Conses`

> "Function"

**Syntax**:

```
copy-list list => copy
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 262. `copy-pprint-dispatch` `Printer`
# 263. `copy-readtable` `Reader`
# 264. `copy-seq` `Sequences`
# 265. `copy-structure` `Structures`
# 266. `copy-symbol` `Symbols`
# 267. `copy-tree` `Conses`
# 268. `cos` `Numbers`
# 269. `cosh` `Numbers`
# 270. `count` `Sequences`
# 271. `count-if` `Sequences`
# 272. `count-if-not` `Sequences`
# 273. `ctypecase` `Data and Control Flow`
# 274. `debug`: 见`optimize`.
# 275. `decf` `Numbers`
# 276. `declaim` `Evaluation and Compilation`
# 277. `declaration` `Evaluation and Compilation`
# 278. `declare` `Evaluation and Compilation`
# 279. `decode-float` `Numbers`
# 280. `decode-universal-time` `Environment`
# 281. `defclass` `Objects`

**Syntax**:

```
defclass class-name ({superclass-name}*) ({slot-specifier}*) [[class-option]]

=> new-class

slot-specifier::= slot-name | (slot-name [[slot-option]])
slot-name::= symbol
slot-option::= {:reader reader-function-name}* | 
               {:writer writer-function-name}* | 
               {:accessor reader-function-name}* | 
               {:allocation allocation-type} | 
               {:initarg initarg-name}* | 
               {:initform form} | 
               {:type type-specifier} | 
               {:documentation string} 
function-name::= {symbol | (setf symbol)}
class-option::= (:default-initargs . initarg-list) | 
                (:documentation string) | 
                (:metaclass class-name) 
```

**Arguments and Values**:

class-name

一个非`nil`的符号

superclass-name

一个非`nil`的符号

slot-name

一个符号. 语法上可用做变量名称的符号.

reader-function-name

一个非`nil`的符号. 在指定槽上可以有多个`:reader`.

writer-function-name

一个广义函数名称. 在指定槽上可以有多个`:writer`.

reader-function-name

一个非`nil`的符号. 在指定槽上可以有多个`:accessor`.

allocation-type

值有`:instance`和`:class`. 在指定槽上最多有一个`:allocation`.

initarg-name

一个符号. 在指定槽上可以有多个`:initarg`.

form

一个形式. 在指定槽上最多有一个`:init-form`.

type-specifier

一个类型描述符. 在指定槽上最多有一个`:type`.

class-option

整体引用类, 或引用类的所有槽.

initarg-list

初始化参数名称和默认初始值形式的一个列表. 最多有一个`:default-initargs`.

class-name

一个非`nil`的符号. 最多有一个`:metaclass`.

new-class

新的类对象.

**Description**:

`defclass`宏定义了一个新的命名类, 返回新的类对象作为结果.

`defclass`的语法提供了指定槽初始化参数的选项, 包括描指定的默认初始值, 为读写槽值自动生成指定广义函数的方法. 默认不定义读写函数, 它们的生成必须显式请求. 但是槽总是可以通过slot-value访问.

定义一个新类总是导致定义一个有相同名称的类型. 如果`object`的类是名为`class-name`的类或`class-name`的子类, 谓词`(typep object class-name)`返回true. 一个类对象可以用作类型描述符. 如果`object`的类是`class`或者`class`的子类, `(typep object class)`返回true.

参数`class-name`指定了新类的合式名称. 如果已存在相同的合式名称类且该类是`standard-class`的实例, 并且如果定义新类的`defclass`形式定义了为`standard-class`实例的类, 则已存在的类被重定义, 并且它和它子类的实例在下次被访问时更新成新的定义. 详情见4.3.6 重定义类.

每个`superclass-name`参数指定了新类的直接超类. 如果超类列表为, 则超类默认依赖于元类, 对于standard-class默认是standard-object.

新类将继承它的每个直接超类的槽和方法, 直接超类的直接超类的槽和方法, 以次类推. 槽和方法如何继承的讨论见4.3.4 继承.

有如下的槽选项可用:

- `:reader`槽选项指定了名为`reader-function-name`的广义函数上未限定的方法, 以读取指定槽的值.
- `:writer`槽选线指定了名为`writer-function-name`的广义函数上未限定的方法, 以写入指定槽的值.
- `:accessor`槽选项指定了名为`reader-function-name`的广义函数上未限定的方法, 以读取指定槽的值, 和名为`(setf reader-function-name)`的广义函数上未限定的方法, 以结合setf使用修改槽值.
- `:allocation`槽选项用于指定指定槽的存储如何分配. 槽的存储可以分配在每个实例中或类对象中. `allocation-type`参数的值可以是关键字`:instance`或者关键字`:class`. 如果`:allocation`槽选项未指定, 则效果与指定`:allocation :instance`相同.
    - 如果`allocation-type`值为`:instance`, 则在类的每个实例上分配名为`slot-name`的局部槽.
    - 如果`allocation-type`值为`:class`, 则在该`defclass`形式创建的类对象中分配给定名称共享槽. 该槽的值被类的所有实例共享. 如果𝐶1C1类定义了一个共享槽, 则𝐶1C1的任意子类𝐶2C2共享这个槽, 除非𝐶2C2的`defclass`形式指定了相同名称的槽, 或者在𝐶2C2的类优先级列表中𝐶1C1之前的类定义了相同名称的槽.
- `:initarg`槽选项声明了名为`initarg-name`的初始化参数, 指定该初始化实现初始化该槽. 如果在调用initialize-instance时该初始化参数有值, 则该值将存储在该操作, 并且该槽的`:initform`槽选项(如果有的话)不被求值. 如果没有指定槽的初始化参数, 如果该槽有`:initform`槽选项, 则根据它初始化槽的值.
- `:type`槽选项指定了槽的内容总是特定的数据类型. 它实际上声明了该类的对象上读广义函数的结果类型. 尝试在槽中存储不满足槽类型的值结果是未定义的. `:type`槽选项的进一步讨论见7.5.3 槽继承和槽选项.
- `:documentation`槽选项提供了槽的文档字符串. 给定槽上至多有一个`:documentation`.

每个类选项是将类作为整体引用的选项. 有如下类选项可用:

- `:default-initargs`类选项后接初始化参数名称和模式初始值形式的列表. 如果在make-instance的初始化参数列表中未出现这些初始化参数, 详情的初始值形式被求值, 在实例创建之前将初始化参数名称和形式的值追加到初始化参数列表后, 见7.1 对象创建和初始化. 默认初始值形式在每次使用时求值. 该形式被求值的词法环境是`defclass`形式被求值的词法环境. 动态环境是make-instance被调用时的动态环境. 如果在`:default-initargs`类选项中一个初始化参数名称出现多次, 抛出错误.
- `:documentation`类选项在类对象上附加文档字符串, `type`是`class-name`. `:documentation`至多有一个.
- `:metaclass`类选项指定类的实例有不同于系统默认提供的`standard-class`的元类.

注意这些标准类的`defclass`的规则:

- 不要求所定义类的超类在所定义类的`defclass`形式求值前已定义.
- 所定义类的超类必须在创建所定义类的实例之前已定义.
- 类必须在它被用作`defmethod`形式的参数特化符之前已定义.

对象系统可以被扩展以涵盖这些规则未被遵守的情况.

一些槽选项是从类的超类继承的, 一些可以通过提供局部槽描述来遮盖或修改. 除`:default-initargs`外的类选项不能被继承. 关于槽和槽选项继承的详细描述见7.5.3 槽和槽选项的继承

可以扩展`defclass`的选项. 要求所有实现在观察到类选项或槽选项不是其本地实现时抛出错误.

可以给一个槽指定多个读取, 写入和访问函数或初始化参数. 其它槽选项不可以在单个槽描述中出现多次, 否则抛出错误.

如果没有给槽指定读取, 写入和访问函数, 只可以通过`slot-value`函数访问槽.

如果一个`defclass`形式作为顶层形式出现, 编译器必须确保该类的名称在后续声明中被识别为有效的类型名称, 在`defmethod`参数特化符中被识别为有效的类名称, 以及能够用在后续`defclass`的`:metaclass`选项中. 编译器必须确保在`find-class`的`environment`参数是作为一个宏的环境参数接收的值时, 能够返回该类的定义.

**Examples**:

无.

**Affected By**:

无.

**Exceptional Situations**:

如果存在重复的槽名称, 抛出类型为`program-error`的错误.

如果在`:default-initargs`类选项中一个初始化参数名称出现多次, 抛出类型为`program-error`的错误.

如果这些槽选项在单个槽描述中出现多次, 抛出类型为`program-error`的错误: `:allocation`, `:initform`, `:type`, `:documentation`.

要求所有实现在观察到类选项或槽选项不是其本地实现时抛出类型为`program-error`的错误.

**See Also**:

documentation, initialize-instance, make-instance, slot-value, 4.3 类, 4.3.4 继承, 4.3.6 重定义类, 4.3.5 确定类优先级列表, 7.1 对象创建和初始化

**Notes**:

无.

# 282. `defconstant` `Data and Control Flow`
# 283. `defgeneric` `Objects`
# 284. `define-compiler-macro` `Evaluation and Compilation`
# 285. `define-condition` `Conditions`
# 286. `define-method-combination` `Objects`
# 287. `define-modify-macro` `Data and Control Flow`
# 288. `define-setf-expander` `Data and Control Flow`
# 289. `define-symbol-macro` `Evaluation and Compilation`
# 290. `defmacro` `Evaluation and Compilation`
# 291. `defmethod` `Objects`
# 292. `defpackage` `Packages`
# 293. `defparameter` `Data and Control Flow`

**Syntax**:

```
defparameter name initial-value [documentation] => name

defvar name [initial-value [documentation]] => name
```

**Arguments and Values**:

- `name`: 一个符号, 不被求值.
- `initial-value`: 一个形式, 在`defparameter`中它总是被求值, 在`defvar`中它只在`name`未绑定时被求值.
- `documentation`: 一个字符串, 不被求值.

**Description**:

`defparameter`和`defvar`将`name`建立为动态变量.

`defparameter`无条件的将`initial-value`赋值为名为`name`的动态变量. `defvar`只在名为`name`的动态变量未绑定时赋予其`initial-value`(如果提供了).

如果没有提供`initial-value`, `defvar`不处理名为`name`的动态变量的值cell; 如果`name`之前已绑定, 它的旧值仍有效, 如果`name`之前未绑定, 则保持未绑定状态.

如果提供了`documentation`, 它将作为类型为`variable`的文档字符串附加到`name`上.

`defparameter`和`defvar`通常作为顶层形式出现, 但它们出现在非顶层形式中也有含义. 下面描述的编译时副作用只在它们作为顶层形式出现时发生.

**Examples**:

```
 (defparameter *p* 1) =>  *P*
 *p* =>  1
 (constantp '*p*) =>  false
 (setq *p* 2) =>  2
 (defparameter *p* 3) =>  *P*
 *p* =>  3

 (defvar *v* 1) =>  *V*
 *v* =>  1
 (constantp '*v*) =>  false
 (setq *v* 2) =>  2
 (defvar *v* 3) =>  *V*
 *v* =>  2

 (defun foo ()
   (let ((*p* 'p) (*v* 'v))
     (bar))) =>  FOO
 (defun bar () (list *p* *v*)) =>  BAR
 (foo) =>  (P V)
```

**Side Effects**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 294. `defsetf` `Data and Control Flow`
# 295. `defstruct` `Structures`
# 296. `deftype` `Types and Classes`
# 297. `defun` `Data and Control Flow`

> "Macro"

**Syntax**:

```
defun function-name lambda-list [[declaration* | documentation]] form*

=> function-name
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 298. `defvar` `Data and Control Flow`
# 299. `delete` `Sequences`
# 300. `delete-duplicates` `Sequences`
# 301. `delete-file` `Files`
# 302. `delete-if` `Sequences`
# 303. `delete-if-not` `Sequences`
# 304. `delete-package` `Packages`
# 305. `denominator` `Numbers`
# 306. `deposit-field` `Numbers`
# 307. `describe` `Environment`
# 308. `describe-object` `Environment`
# 309. `destructuring-bind` `Data and Control Flow`
# 310. `digit-char` `Characters`
# 311. `digit-char-p` `Characters`
# 312. `directory` `Files`
# 313. `directory-namestring` `Filenames`
# 314. `disassemble` `Environment`
# 315. `division-by-zero` `Numbers`
# 316. `do` `Iteration`

> "Macro"

**Syntax**:

```
do ({var | (var [init-form [step-form]])}*)
  (end-test-form result-form*)
  declaration*
  {tag | statement}*
=> result*

do* ({var | (var [init-form [step-form]])}*)
  (end-test-form result-form*)
  declaration*
  {tag | statement}*
=> result*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 317. `do*` `Iteration`
# 318. `do-all-symbols` `Packages`
# 319. `do-external-symbols` `Packages`
# 320. `do-symbols` `Packages`
# 321. `documentation` `Environment`
# 322. `dolist` `Iteration`
# 323. `dotimes` `Iteration`

> "Macro"

**Syntax**:

```
dotimes (var count-form [result-form]) declaration* {tag | statement}*

=> result*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 324. `double-float` `Numbers`
# 325. `double-float-epsilon` `Numbers`
# 326. `double-float-negative-epsilon` `Numbers`
# 327. `dpb` `Numbers`
# 328. `dribble` `Environment`
# 329. `dynamic-extent` `Evaluation and Compilation`
# 330. `ecase` `Data and Control Flow`
# 331. `echo-stream` `Streams`
# 332. `echo-stream-input-stream` `Streams`
# 333. `echo-stream-output-stream` `Streams`
# 334. `ed` `Environment`
# 335. `eighth` `Conses`
# 336. `elt` `Sequences`
# 337. `encode-universal-time` `Environment`
# 338. `end-of-file` `Streams`
# 339. `endp` `Conses`
# 340. `enough-namestring` `Filenames`
# 341. `ensure-directories-exist` `Files`
# 342. `ensure-generic-function` `Objects`
# 343. `eq` `Data and Control Flow`

> "Function"

**Syntax**:

```
eq x y => generalized-boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 344. `eql` `Data and Control Flow` `Types and Classes`

> "Function"

**Syntax**:

```
eql x y => generalized-boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 345. `equal` `Data and Control Flow`

> "Function"

**Syntax**:

```
equal x y => generalized-boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 346. `equalp` `Data and Control Flow`
# 347. `error` `Conditions`
# 348. `etypecase` `Data and Control Flow`
# 349. `eval` `Evaluation and Compilation`
# 350. `eval-when` `Evaluation and Compilation`

> "Special Operator"

**Syntax**:

```
eval-when (situation*) form* => result*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 351. `evenp` `Numbers`
# 352. `every` `Data and Control Flow`
# 353. `exp` `Numbers`
# 354. `export` `Packages`
# 355. `expt` `Numbers`
# 356. `extended-char` `Characters`
# 357. `fboundp` `Data and Control Flow`
# 358. `fceiling` `Numbers`
# 359. `fdefinition` `Data and Control Flow`
# 360. `ffloor` `Numbers`
# 361. `fifth` `Conses`
# 362. `file-author` `Files`
# 363. `file-error` `Files`
# 364. `file-error-pathname` `Files`
# 365. `file-length` `Streams`
# 366. `file-namestring` `Filenames`
# 367. `file-position` `Streams`
# 368. `file-stream` `Streams`
# 369. `file-string-length` `Streams`
# 370. `file-write-date` `Files`
# 371. `fill` `Sequences`
# 372. `fill-pointer` `Arrays`
# 373. `find` `Sequences`
# 374. `find-all-symbols` `Packages`
# 375. `find-class` `Objects`
# 376. `find-if` `Sequences`
# 377. `find-if-not` `Sequences`
# 378. `find-method` `Objects`
# 379. `find-package` `Packages`
# 380. `find-restart` `Conditions`
# 381. `find-symbol` `Packages`
# 382. `finish-output` `Streams`
# 383. `first` `Conses`
# 384. `fixnum` `Numbers`
# 385. `flet` `Data and Control Flow`
# 386. `float` `Numbers`
# 387. `float-digits` `Numbers`
# 388. `float-precision` `Numbers`
# 389. `float-radix` `Numbers`
# 390. `float-sign` `Numbers`
# 391. `floating-point-inexact` `Numbers`
# 392. `floating-point-invalid-operation` `Numbers`
# 393. `floating-point-overflow` `Numbers`
# 394. `floating-point-underflow` `Numbers`
# 395. `floatp` `Numbers`
# 396. `floor` `Numbers`
# 397. `fmakunbound` `Data and Control Flow`
# 398. `force-output` `Streams`
# 399. `format` `Printer`
# 400. `formatter` `Printer`
# 401. `fourth` `Conses`
# 402. `fresh-line` `Streams`
# 403. `fround` `Numbers`
# 404. `ftruncate` `Numbers`

> "Function"

**Syntax**:

```
floor number &optional divisor => quotient, remainder
ffloor number &optional divisor => quotient, remainder
ceiling number &optional divisor => quotient, remainder
fceiling number &optional divisor => quotient, remainder
truncate number &optional divisor => quotient, remainder
ftruncate number &optional divisor => quotient, remainder
round number &optional divisor => quotient, remainder
fround number &optional divisor => quotient, remainder
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 405. `ftype` `Evaluation and Compilation`
# 406. `funcall` `Data and Control Flow`

> "Function"

**Syntax**:

```
funcall function &rest args => result*
```

**Arguments and Values**:

- function: 函数指示器
- args: 函数的参数
- results: 函数的返回值

**Description**:

`funcall`在使用参数`args`调用函数`function`. 如果`function`是个符号, 通过在全局环境中找到其函数值将其转换为一个函数.

**Examples**:

```
(funcall #'+ 1 2 3) =>  6
(funcall 'car '(1 2 3)) =>  1
(funcall 'position 1 '(1 2 3 2 1) :start 1) =>  4
(cons 1 2) =>  (1 . 2)
(flet ((cons (x y) `(kons ,x ,y)))
  (let ((cons (symbol-function '+)))
(funcall #'cons
         (funcall 'cons 1 2)
         (funcall cons 1 2))))
=>  (KONS (1 . 2) 3)
```

**Affected By**: 无.

**Exceptional Situations**:

如果`function`是个符号, 且没有全局定义的同名函数或者是全局定义的同名宏或特殊操作符时, 发出类型为`undefined-function`的错误信号.

**See Also**:

apply, function, 3.1 求值.

**Notes**:

```
(funcall function arg1 arg2 ...)
==  (apply function arg1 arg2 ... nil)
==  (apply function (list arg1 arg2 ...))
```

`funcall`和普通函数调用之前的区别是, 前者是通过求值一个形式获得的函数, 而后者是在函数通常出现的位置做特殊解释获得的.

# 407. `function` `Data and Control Flow` `Types and Classes`

> "Special Operator"

**Syntax**:

```
function name => function
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 408. `function-keywords` `Objects`
# 409. `function-lambda-expression` `Data and Control Flow`
# 410. `functionp` `Data and Control Flow`
# 411. `gcd` `Numbers`
# 412. `generic-function` `Types and Classes`
# 413. `gensym` `Symbols`
# 414. `gentemp` `Symbols`
# 415. `get` `Symbols`
# 416. `get-decoded-time` `Environment`
# 417. `get-dispatch-macro-character` `Reader`
# 418. `get-internal-real-time` `Environment`
# 419. `get-internal-run-time` `Environment`
# 420. `get-macro-character` `Reader`
# 421. `get-output-stream-string` `Streams`
# 422. `get-properties` `Conses`
# 423. `get-setf-expansion` `Data and Control Flow`
# 424. `get-universal-time` `Environment`
# 425. `getf` `Conses`
# 426. `gethash` `Hash Tables`
# 427. `go` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
go tag =>|
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 428. `graphic-char-p` `Characters`
# 429. `handler-bind` `Conditions`
# 430. `handler-case` `Conditions`
# 431. `hash-table` `Hash Tables`
# 432. `hash-table-count` `Hash Tables`
# 433. `hash-table-p` `Hash Tables`
# 434. `hash-table-rehash-size` `Hash Tables`
# 435. `hash-table-rehash-threshold` `Hash Tables`
# 436. `hash-table-size` `Hash Tables`
# 437. `hash-table-test` `Hash Tables`
# 438. `host-namestring` `Filenames`
# 439. `identity` `Data and Control Flow`
# 440. `if` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
if test-form then-form [else-form] => result*
```

**Arguments and Values**:

- `test-form`: 一个形式
- `then-form`: 一个形式
- `else-form`:一个形式, 默认为`nil`
- `results`: 如果`test-form`为true, `then-form`返回的结果; 否则是`else-form`返回的结果

**Description**:

`if`允许依赖于单个`test-form`执行形式.

首先求值`test-form`, 如果其结果为true, 则选择`then-form`, 否则选择`else-form`. 对选择的形式求值.

**Examples**:

```
(if t 1) =>  1
(if nil 1 2) =>  2

(defun test ()
(dolist (truth-value '(t nil 1 (a b c)))
	(if truth-value (print 'true) (print 'false))
	(prin1 truth-value))) =>  TEST
(test)
>>  TRUE T
>>  FALSE NIL
>>  TRUE 1
>>  TRUE (A B C)
=>  NIL
```

**Affected By**: 无.

**Exceptional Situations**: 无.

**See Also**:

cond, unless, when

**Notes**:

```
 (if test-form then-form else-form)
 ==
 (cond (test-form then-form)
   (t else-form))
```

# 441. `ignorable` `Evaluation and Compilation`
# 442. `ignore` `Evaluation and Compilation`
# 443. `ignore-errors` `Conditions`
# 444. `imagpart` `Numbers`
# 445. `import` `Packages`
# 446. `in-package` `Packages`
# 447. `incf` `Numbers`
# 448. `initialize-instance` `Objects`
# 449. `inline` `Evaluation and Compilation`
# 450. `input-stream-p` `Streams`
# 451. `inspect` `Environment`
# 452. `integer` `Numbers`
# 453. `integer-decode-float` `Numbers`
# 454. `integer-length` `Numbers`
# 455. `integerp` `Numbers`

> "Function"

**Syntax**:

```
integerp object => generalized-boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 456. `interactive-stream-p` `Streams`
# 457. `intern` `Packages`
# 458. `internal-time-units-per-second` `Environment`
# 459. `intersection` `Conses`
# 460. `invalid-method-error` `Conditions`
# 461. `invoke-debugger` `Conditions`
# 462. `invoke-restart` `Conditions`
# 463. `invoke-restart-interactively` `Conditions`
# 464. `isqrt` `Numbers`
# 465. `keyword` `Symbols`
# 466. `keywordp` `Symbols`
# 467. `labels` `Data and Control Flow`
# 468. `lambda` `Evaluation and Compilation`
# 469. `lambda-list-keywords` `Data and Control Flow`
# 470. `lambda-parameters-limit` `Data and Control Flow`
# 471. `last` `Conses`

> "Function"

**Syntax**:

```
last list &optional n => tail
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 472. `lcm` `Numbers`
# 473. `ldb` `Numbers`
# 474. `ldb-test` `Numbers`
# 475. `ldiff` `Conses`
# 476. `least-negative-double-float` `Numbers`
# 477. `least-negative-long-float` `Numbers`
# 478. `least-negative-normalized-double-float` `Numbers`
# 479. `least-negative-normalized-long-float` `Numbers`
# 480. `least-negative-normalized-short-float` `Numbers`
# 481. `least-negative-normalized-single-float` `Numbers`
# 482. `least-negative-short-float` `Numbers`
# 483. `least-negative-single-float` `Numbers`
# 484. `least-positive-double-float` `Numbers`
# 485. `least-positive-long-float` `Numbers`
# 486. `least-positive-normalized-double-float` `Numbers`
# 487. `least-positive-normalized-long-float` `Numbers`
# 488. `least-positive-normalized-short-float` `Numbers`
# 489. `least-positive-normalized-single-float` `Numbers`
# 490. `least-positive-short-float` `Numbers`
# 491. `least-positive-single-float` `Numbers`
# 492. `length` `Sequences`

> "Function"

**Syntax**:

```
length sequence => n
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 493. `let` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
let ( { var | (var [init-form]) }* ) declaration* form* => result*
let* ( { var | (var [init-form]) }* ) declaration* form* => result*
```

**Arguments and Values**:

- `var`: 一个符号
- `init-form`: 一个形式(称为初始值形式)
- `declaration`: 一个`declare`表达式, 不被求值
- `form`: 一个形式
- `results`: `forms`返回的值

**Description**:

`let`和`let*` **创建新的变量绑定**, 并使用这些绑定执行一组形式. `let`按并行方式执行绑定, `let*`按串行方式执行绑定.

形式

```
(let ((var1 init-form-1)
		(var2 init-form-2)
		...
		(varm init-form-m))
declaration1
declaration2
...
declarationp
form1
form2
...
formn)
```

首先按顺序求值表达式`init-form-1`、`init-form-2`等, 保存结果值. 然后所有变量`varj`绑定到对应的值; 每个绑定是 **词法的**, 除非存在相反的`special`声明. 接着按顺序求值`formk`; 除最后一个值外丢弃所有值(即, `let`的体是一个隐式的`progn`).

`let*`与`let`相似, 但按串行方式执行变量绑定. 一个`var`的`init-form`表达式可以引用前面绑定的`var`.

形式

```
(let* ((var1 init-form-1)
		 (var2 init-form-2)
		 ...
		 (varm init-form-m))
declaration1
declaration2
...
declarationp
form1
form2
...
formn)
```

首先求值表达式`init-form-1`, 将结果绑定到`var1`; 然后求值表达式`init-form-2`, 将结果绑定到`var2`, 等等. 接着, 表达式`formj`按序求值; 除最后一个值外丢弃所有值(即, `let*`的体是一个隐式的`progn`).

在`let`和`let*`中, 如果一个`var`没有对应的`init-form`, 则`var`初始化为`nil`.

特殊形式`let`有属性: 名称绑定的作用域不包含任意初始值形式. 对于`let*`, 变量的作用域也包含之后的变量绑定中剩余的初始值形式.

**Examples**:

```
(setq a 'top) =>  TOP
(defun dummy-function () a) =>  DUMMY-FUNCTION

(let ((a 'inside) (b a)) ;(b a)中a是指toplevel的a
 (format nil "~S ~S ~S" a b (dummy-function))) =>  "INSIDE TOP TOP"

(let* ((a 'inside) (b a));(b a)中a是指前一个绑定的变量
 (format nil "~S ~S ~S" a b (dummy-function))) =>  "INSIDE INSIDE TOP"

(let ((a 'inside) (b a))
 (declare (special a)) ;将a改为非词法的
 (format nil "~S ~S ~S" a b (dummy-function))) =>  "INSIDE TOP INSIDE"
```

下面的代码是不正确的.

```
(let (x)
(declare (integer x))
(setq x (gcd y z))
...)
```

`x`的初始值为`nil`, 违背了类型声明`(declare (integer x))`.

**Affected By**: 无.

**Exceptional Situations**: 无.

**See Also**:

progv

**Notes**: 无.

# 494. `let*` `Data and Control Flow`
# 495. `lisp-implementation-type` `Environment`
# 496. `lisp-implementation-version` `Environment`
# 497. `list` `Conses`

> "Function"

**Syntax**:

```
list &rest objects => list
list* &rest objects+ => result
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 498. `list*` `Conses`
# 499. `list-all-packages` `Packages`
# 500. `list-length` `Conses`
# 501. `listen` `Streams`
# 502. `listp` `Conses`

> "Function"

**Syntax**:

```
listp object => generalized-boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 503. `load` `System`
# 504. `load-logical-pathname-translations` `Filenames`
# 505. `load-time-value` `Evaluation and Compilation`

> "Special Operator"

**Syntax**:

```
load-time-value form &optional read-only-p => object
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 506. `locally` `Evaluation and Compilation`

> "Special Operator"

**Syntax**:

```
locally declaration* form* => result*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 507. `log` `Numbers`
# 508. `logand` `Numbers`
# 509. `logandc1` `Numbers`
# 510. `logandc2` `Numbers`
# 511. `logbitp` `Numbers`
# 512. `logcount` `Numbers`
# 513. `logeqv` `Numbers`
# 514. `logical-pathname` `Filenames`
# 515. `logical-pathname-translations` `Filenames`
# 516. `logior` `Numbers`
# 517. `lognand` `Numbers`
# 518. `lognor` `Numbers`
# 519. `lognot` `Numbers`
# 520. `logorc1` `Numbers`
# 521. `logorc2` `Numbers`
# 522. `logtest` `Numbers`
# 523. `logxor` `Numbers`
# 524. `long-float` `Numbers`
# 525. `long-float-epsilon` `Numbers`
# 526. `long-float-negative-epsilon` `Numbers`
# 527. `long-site-name` `Environment`
# 528. `loop` `Iteration`

> "Macro"

**Syntax**:

```
; 简单的循环形式
loop compound-form* => result*
; 扩展的循环形式
loop [name-clause] { variable-clause }* { main-clause }* => result*
```

```
(* 1 名称从句 *)
name-clause::= named name

(* 2 变量从句 *)
variable-clause::= with-clause | initial-final | for-as-clause
(* 2.1 WITH从句 *)
with-clause::= with var1 [type-spec] [= form1] { and var2 [type-spec] [= form2] }*

(* 3 主从句 *)
main-clause::= unconditional | accumulation | conditional | termination-test | initial-final

(* 2.2/3.5 序言和后继从句 *)
initial-final::= initially compound-form+ | finally compound-form+

(* 3.1 无条件执行从句 *)
unconditional::= { do | doing } compound-form+ | return { form | it }
(* 3.2 累积从句 *)
accumulation::= list-accumulation | numeric-accumulation
list-accumulation::= { collect | collecting | append | appending | nconc | nconcing } { form | it }
                     [into simple-var]
numeric-accumulation::= { count | counting | sum | summing | }
                         maximize | maximizing | minimize | minimizing { form | it }
                        [into simple-var] [type-spec]
(* 3.3 条件执行从句 *)
conditional::= { if | when | unless } form selectable-clause { and selectable-clause }*
               [else selectable-clause { and selectable-clause }*]
               [end]
selectable-clause::= unconditional | accumulation | conditional
(* 3.4 终止测试从句 *)
termination-test::= while form | until form | repeat form | always form | never form | thereis form

(* 2.3 for-as从句 *)
for-as-clause::= { for | as } for-as-subclause { and for-as-subclause }*
for-as-subclause::= for-as-arithmetic | for-as-in-list | for-as-on-list | for-as-equals-then |
                    for-as-across | for-as-hash | for-as-package
for-as-arithmetic::= var [type-spec] for-as-arithmetic-subclause
for-as-arithmetic-subclause::= arithmetic-up | arithmetic-downto | arithmetic-downfrom
arithmetic-up::= [ [ { from | upfrom } form1
                    | { to | upto | below } form2
                    | by form3 ] ]+
arithmetic-downto::= [ [ {{ from form1 }}1
                        | {{ { downto | above } form2 }}1
                        | by form3 ] ]
arithmetic-downfrom::= [ [ {{ downfrom form1 }}1
                          | { to | downto | above } form2
                          | by form3 ] ]
for-as-in-list::= var [type-spec] in form1 [by step-fun]
for-as-on-list::= var [type-spec] on form1 [by step-fun]
for-as-equals-then::= var [type-spec] = form1 [then form2]
for-as-across::= var [type-spec] across vector
for-as-hash::= var [type-spec] being { each | the }
               { { hash-key | hash-keys } { in | of } hash-table
                 [using (hash-value other-var)]
               | { hash-value | hash-values } { in | of } hash-table
                 [using (hash-key other-var)]}
for-as-package::= var [type-spec] being { each | the }
                  { symbol | symbols
                  | present-symbol | present-symbols
                  | external-symbol | external-symbols }
                  [{ in | of } package]
(* 2.1.1 类型描述和变量 *)
type-spec::= simple-type-spec | destructured-type-spec
simple-type-spec::= fixnum | float | t | nil
destructured-type-spec::= of-type d-type-spec
d-type-spec::= type-specifier | (d-type-spec . d-type-spec)
var::= d-var-spec
var1::= d-var-spec
var2::= d-var-spec
other-var::= d-var-spec
d-var-spec::= simple-var | nil | (d-var-spec . d-var-spec)
```

**Arguments and Values**:

- `compound-form`: 一个复合形式
- `name`: 一个符号
- `simple-var`: 一个符号(变量名称)
- `form, form1, form2, form3`: 一个形式
- `step-fun`: 求值为单个传递参数的函数肚饿形式
- `vector`: 求值为向量的形式
- `hash-table`: 求值为哈希表的形式
- `package`: 求值为包指示器的形式
- `type-specifier`: 一个类型描述符. 可以是原子类型描述符或复合类型描述符, 在解构中恰当解析方面引入了额外的复杂性; 更多信息见6.1.1.7 解构.
- `result`: 一个对象

**Description**:

见6.1 循环功能.

**Examples**:

```
;; An example of the simple form of LOOP.
 (defun sqrt-advisor ()
   (loop (format t "~&Number: ")
     (let ((n (parse-integer (read-line) :junk-allowed t)))
       (when (not n) (return))
       (format t "~&The square root of ~D is ~D.~%" n (sqrt n)))))
=>  SQRT-ADVISOR
 (sqrt-advisor)
>>  Number: 5<NEWLINE>
>>  The square root of 5 is 2.236068.
>>  Number: 4<NEWLINE>
>>  The square root of 4 is 2.
>>  Number: done<NEWLINE>
=>  NIL

;; An example of the extended form of LOOP.
 (defun square-advisor ()
   (loop as n = (progn (format t "~&Number: ")
                   (parse-integer (read-line) :junk-allowed t))
     while n
     do (format t "~&The square of ~D is ~D.~%" n (* n n))))
=>  SQUARE-ADVISOR
 (square-advisor)
>>  Number: 4<NEWLINE>
>>  The square of 4 is 16.
>>  Number: 23<NEWLINE>
>>  The square of 23 is 529.
>>  Number: done<NEWLINE>
=>  NIL

;; Another example of the extended form of LOOP.
 (loop for n from 1 to 10
   when (oddp n)
     collect n)
=>  (1 3 5 7 9)
```

**Affected By**: 无.

**Exceptional Situations**: 无.

**See Also**:

do, dolist, dotimes, return, go, throw, 6.1.1.7 解构.

**Notes**:

除了简单的循环形式中不能用本地宏`loop-finish`, 简单的循环形式与扩展的循环形式按如下方式关联:

```
(loop compound-form*) ==  (loop do compound-form*)
```

# 529. `loop-finish` `Iteration`
# 530. `lower-case-p` `Characters`
# 531. `machine-instance` `Environment`
# 532. `machine-type` `Environment`
# 533. `machine-version` `Environment`
# 534. `macro-function` `Evaluation and Compilation`
# 535. `macroexpand` `Evaluation and Compilation`
# 536. `macroexpand-1` `Evaluation and Compilation`
# 537. `macrolet` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
flet ((function-name lambda-list [[local-declaration* | local-documentation]] local-form*)*) declaration* form*
=> result*

labels ((function-name lambda-list [[local-declaration* | local-documentation]] local-form*)*) declaration* form*
=> result*

macrolet ((name lambda-list [[local-declaration* | local-documentation]] local-form*)*) declaration* form*
=> result*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 538. `make-array` `Arrays`
# 539. `make-broadcast-stream` `Streams`
# 540. `make-concatenated-stream` `Streams`
# 541. `make-condition` `Conditions`
# 542. `make-dispatch-macro-character` `Reader`
# 543. `make-echo-stream` `Streams`
# 544. `make-hash-table` `Hash Tables`
# 545. `make-instance` `Objects`
# 546. `make-instances-obsolete` `Objects`
# 547. `make-list` `Conses`
# 548. `make-load-form` `Objects`
# 549. `make-load-form-saving-slots` `Objects`
# 550. `make-method` `Objects`
# 551. `make-package` `Packages`
# 552. `make-pathname` `Filenames`
# 553. `make-random-state` `Numbers`
# 554. `make-sequence` `Sequences`
# 555. `make-string` `Strings`
# 556. `make-string-input-stream` `Streams`
# 557. `make-string-output-stream` `Streams`
# 558. `make-symbol` `Symbols`
# 559. `make-synonym-stream` `Streams`
# 560. `make-two-way-stream` `Streams`
# 561. `makunbound` `Symbols`
# 562. `map` `Sequences`
# 563. `map-into` `Sequences`
# 564. `mapc` `Conses`
# 565. `mapcan` `Conses`
# 566. `mapcar` `Conses`
# 567. `mapcon` `Conses`

> "Function"

**Syntax**:

```
mapc function &rest lists+ => list-1
mapcar function &rest lists+ => result-list
mapcan function &rest lists+ => concatenated-results
mapl function &rest lists+ => list-1
maplist function &rest lists+ => result-list
mapcon function &rest lists+ => concatenated-results
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 568. `maphash` `Hash Tables`
# 569. `mapl` `Conses`
# 570. `maplist` `Conses`
# 571. `mask-field` `Numbers`
# 572. `max` `Numbers`
# 573. `member` `Conses` `Types and Classes`
# 574. `member-if` `Conses`
# 575. `member-if-not` `Conses`

> "Function"

**Syntax**:

```
member item list &key key test test-not => tail
member-if predicate list &key key => tail
member-if-not predicate list &key key => tail
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 576. `merge` `Sequences`
# 577. `merge-pathnames` `Filenames`
# 578. `method` `Types and Classes`
# 579. `method-combination` `Types and Classes`
# 580. `method-combination-error` `Conditions`
# 581. `method-qualifiers` `Objects`
# 582. `min` `Numbers`
# 583. `minusp` `Numbers`
# 584. `mismatch` `Sequences`
# 585. `mod` `Numbers`
# 586. `most-negative-double-float` `Numbers`
# 587. `most-negative-fixnum` `Numbers`
# 588. `most-negative-long-float` `Numbers`
# 589. `most-negative-short-float` `Numbers`
# 590. `most-negative-single-float` `Numbers`
# 591. `most-positive-double-float` `Numbers`
# 592. `most-positive-fixnum` `Numbers`
# 593. `most-positive-long-float` `Numbers`
# 594. `most-positive-short-float` `Numbers`
# 595. `most-positive-single-float` `Numbers`
# 596. `muffle-warning` `Conditions`
# 597. `multiple-value-bind` `Data and Control Flow`
# 598. `multiple-value-call` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
multiple-value-call function-form form* => result*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 599. `multiple-value-list` `Data and Control Flow`
# 600. `multiple-value-prog1` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
multiple-value-prog1 first-form form* => first-form-results
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 601. `multiple-value-setq` `Data and Control Flow`
# 602. `multiple-values-limit` `Data and Control Flow`
# 603. `name-char` `Characters`
# 604. `namestring` `Filenames`
# 605. `nbutlast` `Conses`
# 606. `nconc` `Conses`
# 607. `next-method-p` `Objects`
# 608. `nil` `Data and Control Flow` `Types and Classes`

> "Constant Variable"
> 
> **Constant Value**:

```
nil
```

**Description**:

**Examples**:

**See Also**:

**Notes**:

# 609. `nintersection` `Conses`

> "Function"

**Syntax**:

```
intersection list-1 list-2 &key key test test-not => result-list
nintersection list-1 list-2 &key key test test-not => result-list
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 610. `ninth` `Conses`
# 611. `no-applicable-method` `Objects`
# 612. `no-next-method` `Objects`
# 613. `not` `Data and Control Flow` `Types and Classes`

> "Function"

**Syntax**:

```
not x => boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 614. `notany` `Data and Control Flow`
# 615. `notevery` `Data and Control Flow`
# 616. `notinline` `Evaluation and Compilation`
# 617. `nreconc` `Conses`
# 618. `nreverse` `Sequences`
# 619. `nset-difference` `Conses`

> "Function"

**Syntax**:

```
set-difference list-1 list-2 &key key test test-not => result-list
nset-difference list-1 list-2 &key key test test-not => result-list
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 620. `nset-exclusive-or` `Conses`
# 621. `nstring-capitalize` `Strings`
# 622. `nstring-downcase` `Strings`
# 623. `nstring-upcase` `Strings`
# 624. `nsublis` `Conses`
# 625. `nsubst` `Conses`
# 626. `nsubst-if` `Conses`
# 627. `nsubst-if-not` `Conses`

> "Function"

**Syntax**:

```
subst new old tree &key key test test-not => new-tree
subst-if new predicate tree &key key => new-tree
subst-if-not new predicate tree &key key => new-tree
nsubst new old tree &key key test test-not => new-tree
nsubst-if new predicate tree &key key => new-tree
nsubst-if-not new predicate tree &key key => new-tree
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 628. `nsubstitute` `Sequences`
# 629. `nsubstitute-if` `Sequences`
# 630. `nsubstitute-if-not` `Sequences`

> "Function"

**Syntax**:

```
substitute newitem olditem sequence &key from-end test test-not start end count key
=> result-sequence

substitute-if newitem predicate sequence &key from-end start end count key
=> result-sequence

substitute-if-not newitem predicate sequence &key from-end start end count key
=> result-sequence

nsubstitute newitem olditem sequence &key from-end test test-not start end count key
=> sequence

nsubstitute-if newitem predicate sequence &key from-end start end count key
=> sequence

nsubstitute-if-not newitem predicate sequence &key from-end start end count key
=> sequence
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 631. `nth` `Conses`

> "Accessor"

**Syntax**:

```
nth n list => object
(setf (nth n list) new-object)
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 632. `nth-value` `Data and Control Flow`
# 633. `nthcdr` `Conses`

> "Function"

**Syntax**:

```
nthcdr n list => tail
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 634. `null` `Conses`

> "Function"

**Syntax**:

```
null object => boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 635. `number` `Numbers`
# 636. `numberp` `Numbers`
# 637. `numerator` `Numbers`
# 638. `nunion` `Conses`

> "Function"

**Syntax**:

```
union list-1 list-2 &key key test test-not => result-list
nunion list-1 list-2 &key key test test-not => result-list
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 639. `oddp` `Numbers`

> "Function"

**Syntax**:

```
evenp integer => generalized-boolean
oddp integer => generalized-boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 640. `open` `Streams`
# 641. `open-stream-p` `Streams`
# 642. `optimize` `Evaluation and Compilation`
# 643. `or` `Data and Control Flow` `Types and Classes`

> "Macro"

**Syntax**:

```
or form* => results*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 644. `otherwise`: 见`case`.
# 645. `output-stream-p` `Streams`
# 646. `package` `Packages`
# 647. `package-error` `Packages`
# 648. `package-error-package` `Packages`
# 649. `package-name` `Packages`
# 650. `package-nicknames` `Packages`
# 651. `package-shadowing-symbols` `Packages`
# 652. `package-use-list` `Packages`
# 653. `package-used-by-list` `Packages`
# 654. `packagep` `Packages`
# 655. `pairlis` `Conses`
# 656. `parse-error` `Conditions`
# 657. `parse-integer` `Numbers`
# 658. `parse-namestring` `Filenames`
# 659. `pathname` `Filenames`
# 660. `pathname-device` `Filenames`
# 661. `pathname-directory` `Filenames`
# 662. `pathname-host` `Filenames`
# 663. `pathname-match-p` `Filenames`
# 664. `pathname-name` `Filenames`
# 665. `pathname-type` `Filenames`
# 666. `pathname-version` `Filenames`
# 667. `pathnamep` `Filenames`
# 668. `peek-char` `Streams`
# 669. `phase` `Numbers`
# 670. `pi` `Numbers`
# 671. `plusp` `Numbers`
# 672. `pop` `Conses`

> "Macro"


**Syntax**:

```
pop place => element
```

**Arguments and Values**:

- `place`: 一个位置, 它的值是一个列表(可以是点列表、循环列表)
- `element`: 一个对象(`place`的内容的car)

**Description**:

`pop`读取`place`的值, 记住检索的列表的car, 将列表的cdr写入`place`, 最终返回原始检索的列表car.

有关`place`的子形式的求值, 见5.1.1.1 子形式到位置的求值.

**Examples**:

```
(setq stack '(a b c)) =>  (A B C)
(pop stack) =>  A
stack =>  (B C)

(setq llst '((1 2 3 4))) =>  ((1 2 3 4))
(pop (car llst)) =>  1
llst =>  ((2 3 4))
```

**Side Effects**: `place`的内容被修改.

**Affected By**: 无.

**Exceptional Situations**: 无.

**See Also**:

push, pushnew, 5.1 通用的引用

**Notes**:

`(pop place)`的作用基本上等价于:

```
(prog1 (car place) (setf place (cdr place)))
```

除了后者会求值`place`的子形式三次, 而`pop`只求值一次.

# 673. `position` `Sequences`
# 674. `position-if` `Sequences`
# 675. `position-if-not` `Sequences`
# 676. `pprint` `Printer`
# 677. `pprint-dispatch` `Printer`
# 678. `pprint-exit-if-list-exhausted` `Printer`
# 679. `pprint-fill` `Printer`
# 680. `pprint-indent` `Printer`
# 681. `pprint-linear` `Printer`
# 682. `pprint-logical-block` `Printer`
# 683. `pprint-newline` `Printer`
# 684. `pprint-pop` `Printer`
# 685. `pprint-tab` `Printer`
# 686. `pprint-tabular` `Printer`
# 687. `prin1` `Printer`
# 688. `prin1-to-string` `Printer`
# 689. `princ` `Printer`
# 690. `princ-to-string` `Printer`
# 691. `print` `Printer`
# 692. `print-not-readable` `Printer`
# 693. `print-not-readable-object` `Printer`
# 694. `print-object` `Printer`
# 695. `print-unreadable-object` `Printer`
# 696. `probe-file` `Files`
# 697. `proclaim` `Evaluation and Compilation`
# 698. `prog` `Data and Control Flow`
# 699. `prog*` `Data and Control Flow`
# 700. `prog1` `Data and Control Flow`
# 701. `prog2` `Data and Control Flow`
# 702. `progn` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
progn form* => result*
```

**Arguments and Values**:

- `forms`: 一个隐式的`progn`
- `results`: `forms`的值

**Description**:

`progn`按给定的顺序求值`forms`. 丢弃除最后一个形式外的值.

如果`progn`作为顶级形式出现, 则`progn`中的`forms`被编译器视为顶级形式.

**Examples**:

```
(progn) =>  NIL
(progn 1 2 3) =>  3
(progn (values 1 2 3)) =>  1, 2, 3

(setq a 1) =>  1
(if a
	 (progn (setq a nil) 'here)
	 (progn (setq a t) 'there)) =>  HERE
a =>  NIL
```

**Affected By**: 无.

**Exceptional Situations**: 无.

**See Also**:

prog1, prog2, 3.1 求值

**Notes**:

Common Lisp中很多地方包含使用隐式`progn`的语法. 即, 作为其语法的一部分, 允许写多个被串行求值的形式, 忽略除最后一个形式的结果, 返回最后一个形式的结果. 这些地方包括但不限于: lambda表达式的体, 多个控制和条件形式的体(`case`、`catch`、`progn`、`when`等).

# 703. `program-error` `Data and Control Flow`
# 704. `progv` `Data and Control Flow`

>"Special Operator"


**Syntax**:

```
progv symbols values form* => result*
```

**Arguments and Values**:

- `symbols`: 符号列表; 被求值
- `values`: 对象列表, 被求值
- `forms`: 隐式`progn`
- `results`: `forms`返回的值

**Description**:

`progv`创建新的 **动态变量** 绑定, 并使用这些绑定执行每个`form`. 按顺序求值每个`form`.

`progv`允许绑定一个或多个 **运行时确定名称的** 动态变量. 每个`form`按顺序求值, 使用名称在`symbols`中的绑定到相应的`values`的动态变量. 如果提供了过少的`values`, 则剩下的符号被绑定为没有值. 如果提供了过多的`values`, 则多余的被忽略. 在从`progv`中退出时, 动态变量的绑定被撤销.

**Examples**:

```
(setq *x* 1) =>  1

(progv '(*x*) '(2) *x*) =>  2
*x* =>  1 ;动态变量绑定被撤销
```

假设`*x*`不是全局特殊的,

```
(let ((*x* 3))				; 变量*x*
 (progv '(*x*) '(4)	; 符号*x*
	 (list *x* (symbol-value '*x*)))) =>  (3 4)
```

**Affected By**: 无.

**Exceptional Situations**: 无.

**See Also**:

let, 3.1 求值(Evaluation)

**Notes**:

`progv`在编写内嵌在Lisp中的语言时很有用, 提供了绑定动态变量的机制.

# 705. `provide` `System`
# 706. `psetf` `Data and Control Flow`

> "Macro"


**Syntax**:

```
setf {pair}* => result*
psetf {pair}* => nil

pair::= place newvalue
```

**Arguments and Values**:

- `place`: 一个位置
- `newvalue`: 一个形式
- `results`: 为最后一个位置存储形式放回的多值, 或在没有`pairs`时返回`nil`

**Description**:

`setf`将`place`的值修改为`newvalue`.

`(setf place newvalue)`展开为一个更新形式, 出处求值`newvalue`的结果到被`place`引用的位置. 一些`place`形式使用带可选传递参数的访问器. 这些可选传递参数是否被`setf`允许, 或它们使用的效果是什么, 是由`setf`展开器函数决定的, 不受`setf`的控制. 任何接受`&optional`、`&rest`或`&key`传递参数且这些传递参数声明为可用于`setf`的函数的文档必须描述如何处理这些传递参数.

如果提供了多个`pair`, `pairs`按顺序处理, 即:

```
(setf place-1 newvalue-1
		place-2 newvalue-2
		...
		place-N newvalue-N)
```

等价于:

```
(progn (setf place-1 newvalue-1)
		 (setf place-2 newvalue-2)
		 ...
		 (setf place-N newvalue-N))
```

对于`psetf`, 如果提供了多个`pair`, 则将新值指派给位置是并行执行的. 待求值的所有子形式(`place`和`newvalue`的形式), 按从左到右的顺序求值; 在所有求值完成后, 所有指派动作按不可预计的顺序执行.

`setf`和`psetf`展开的详情, 见5.1.2 位置的种类.

**Examples**:

```
(setq x (cons 'a 'b) y (list 1 2 3)) =>  (1 2 3)
(setf (car x) 'x (cadr y) (car x) (cdr x) y) =>  (1 X 3)
x =>  (X 1 X 3)
y =>  (1 X 3)

(setq x (cons 'a 'b) y (list 1 2 3)) =>  (1 2 3)
(psetf (car x) 'x (cadr y) (car x) (cdr x) y) =>  NIL
x =>  (X 1 A 3)
y =>  (1 A 3)
```

**Affected By**:

define-setf-expander, defsetf, `*macroexpand-hook*`

**Exceptional Situations**: 无.

**See Also**:

define-setf-expander, defsetf, macroexpand-1, rotatef, shiftf, 5.1 通用的引用

**Notes**: 无.

# 707. `psetq` `Data and Control Flow`
# 708. `push` `Conses`
# 709. `pushnew` `Conses`
# 710. `quote` `Evaluation and Compilation`

> "Special Operator"


**Syntax**:

```
quote object => object
```

**Arguments and Values**:

- `object`: 一个对象, 不被求值

**Description**:

特殊操作符`quote`直接返回`object`.

如果字面量对象(包括被引述的对象)被破坏性修改时, 后果未定义.

**Examples**:

```
(setq a 1) =>  1

(quote (setq a 3)) =>  (SETQ A 3)
a =>  1 ;object未被求值

'a =>  A
''a =>  (QUOTE A)
'''a =>  (QUOTE (QUOTE A))

(setq a 43) =>  43
(list a (cons a 3)) =>  (43 (43 . 3))
(list (quote a) (quote (cons a 3))) =>  (A (CONS A 3))

1 =>  1
'1 =>  1

"foo" =>  "foo"
'"foo" =>  "foo"

(car '(a b)) =>  A
'(car '(a b)) =>  (CAR (QUOTE (A B)))

#(car '(a b)) =>  #(CAR (QUOTE (A B)))
'#(car '(a b)) =>  #(CAR (QUOTE (A B)))
```

**Affected By**: 无.

**Exceptional Situations**: 无.

**See Also**:

3.1 求值(Evaluation), 2.4.3 `'`(single-quote), 3.2.1 编译器术语

**Notes**:

文本记法`'object`等价于`(quote object)`, 见3.2.1 编译器术语.

自求值对象不需要被`quote`引述. 符号和列表用于标识程序的部分, 不使用`quote`不能作为常值数据使用. 因为`quote`抑制了这些对象的求值, 它们称为数据而不是程序.

# 711. `random` `Numbers`
# 712. `random-state` `Numbers`
# 713. `random-state-p` `Numbers`
# 714. `rassoc` `Conses`
# 715. `rassoc-if` `Conses`
# 716. `rassoc-if-not` `Conses`
# 717. `ratio` `Numbers`
# 718. `rational` `Numbers`
# 719. `rationalize` `Numbers`
# 720. `rationalp` `Numbers`
# 721. `read` `Reader`
# 722. `read-byte` `Streams`
# 723. `read-char` `Streams`
# 724. `read-char-no-hang` `Streams`
# 725. `read-delimited-list` `Reader`
# 726. `read-from-string` `Reader`
# 727. `read-line` `Streams`

**Syntax**:

```
read-line &optional input-stream eof-error-p eof-value recursive-p

=> line, missing-newline-p
```

**Arguments and Values**:

input-stream

输入流指示器. 默认是标准输入.

eof-error-p

通用布尔值. 默认为true.

eof-value

一个对象, 默认为`nil`.

recursive-p

通用布尔值. 默认为false.

line

一个字符串或`eof-value`.

missing-newline-p

通用布尔值.

**Description**:

**Examples**:

**Side Effects**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 728. `read-preserving-whitespace` `Reader`
# 729. `read-sequence` `Streams`
# 730. `reader-error` `Reader`
# 731. `readtable` `Reader`
# 732. `readtable-case` `Reader`
# 733. `readtablep` `Reader`
# 734. `real` `Numbers`
# 735. `realp` `Numbers`
# 736. `realpart` `Numbers`
# 737. `reduce` `Sequences`
# 738. `reinitialize-instance` `Objects`
# 739. `rem` `Numbers`

> "Function"

**Syntax**:

```
mod number divisor => modulus
rem number divisor => remainder
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 740. `remf` `Conses`
# 741. `remhash` `Hash Tables`
# 742. `remove` `Sequences`
# 743. `remove-duplicates` `Sequences`
# 744. `remove-if` `Sequences`
# 745. `remove-if-not` `Sequences`
# 746. `remove-method` `Objects`
# 747. `remprop` `Symbols`
# 748. `rename-file` `Files`
# 749. `rename-package` `Packages`
# 750. `replace` `Sequences`
# 751. `require` `System`
# 752. `rest` `Conses`
# 753. `restart` `Conditions`
# 754. `restart-bind` `Conditions`
# 755. `restart-case` `Conditions`
# 756. `restart-name` `Conditions`
# 757. `return` `Data and Control Flow`
# 758. `return-from` `Data and Control Flow`

>"Special Operator"


**Syntax**:

```
return-from name [result] =>|
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 759. `revappend` `Conses`
# 760. `reverse` `Sequences`
# 761. `room` `Environment`
# 762. `rotatef` `Data and Control Flow`
# 763. `round` `Numbers`
# 764. `row-major-aref` `Arrays`
# 765. `rplaca` `Conses`
# 766. `rplacd` `Conses`
# 767. `safety`: 见`optimize`.
# 768. `satisfies` `Types and Classes`
# 769. `sbit` `Arrays`
# 770. `scale-float` `Numbers`
# 771. `schar` `Strings`
# 772. `search` `Sequences`
# 773. `second` `Conses`
# 774. `sequence` `Sequences`
# 775. `serious-condition` `Conditions`
# 776. `set` `Symbols`
# 777. `set-difference` `Conses`
# 778. `set-dispatch-macro-character` `Reader`
# 779. `set-exclusive-or` `Conses`
# 780. `set-macro-character` `Reader`
# 781. `set-pprint-dispatch` `Printer`
# 782. `set-syntax-from-char` `Reader`
# 783. `setf` `Data and Control Flow`
# 784. `setq` `Data and Control Flow`

> "Special Form"

**Syntax**:

```
setq { pair }* => result

pair ::= var form
```

**Pronunciation**: \['set,kyoo]

**Arguments and Values**:

- `var`: 一个符号, 命名了一个不是常值变量的变量
- `form`: 一个形式
- `result`: 最后一个`form`的主值, 或者在没有提供`pair`时为`nil`

**Description**:

赋值给变量. `setq var1 form1 var2 form2 ...`是Lisp中简单的变量赋值语句. 首先`form1`被求值, 其求值结果存放在变量`var1`中, 接着`form2`被求值, 其求值结果存放在变量`var2`中, 等等. `setq`可被用于 **词法** 或 **动态** 变量的赋值.

如果任意一个变量`var`引用了`symbol-macrolet`生成的绑定, 则该变量被视为使用了`setf`(而不是`setq`).

**Examples**:

```
;; A simple use of SETQ to establish values for variables.
(setq a 1 b 2 c 3) =>  3
a =>  1
b =>  2
c =>  3

;; Use of SETQ to update values by sequential assignment.
;; 串行赋值
(setq a (1+ b) b (1+ a) c (+ a b)) =>  7
a =>  3
b =>  4
c =>  7

;; This illustrates the use of SETQ on a symbol macro.
(let ((x (list 10 20 30))) ;x=(10 20 30)
(symbol-macrolet ((y (car x)) (z (cadr x))) ; y=10, z=20
	(setq y (1+ z) z (1+ y)) ;y=21, z=22 -- setf x=(21 22 30)
	(list x y z)))
=>  ((21 22 30) 21 22)
```

**Side Effects**:

每个`form`的主值被赋值给相应的`var`.

**Affected By**: 无.

**Exceptional Situations**: 无.

**See Also**:

psetq, set. setf, symbol-macrolet

**Notes**: 无.

# 785. `seventh` `Conses`
# 786. `shadow` `Packages`
# 787. `shadowing-import` `Packages`
# 788. `shared-initialize` `Objects`
# 789. `shiftf` `Data and Control Flow`
# 790. `short-float` `Numbers`
# 791. `short-float-epsilon` `Numbers`
# 792. `short-float-negative-epsilon` `Numbers`
# 793. `short-site-name` `Environment`
# 794. `signal` `Conditions`
# 795. `signed-byte` `Numbers`
# 796. `signum` `Numbers`
# 797. `simple-array` `Arrays`
# 798. `simple-base-string` `Strings`
# 799. `simple-bit-vector` `Arrays`
# 800. `simple-bit-vector-p` `Arrays`
# 801. `simple-condition` `Conditions`
# 802. `simple-condition-format-arguments` `Conditions`
# 803. `simple-condition-format-control` `Conditions`
# 804. `simple-error` `Conditions`
# 805. `simple-string` `Strings`
# 806. `simple-string-p` `Strings`
# 807. `simple-type-error` `Types and Classes`
# 808. `simple-vector` `Arrays`
# 809. `simple-vector-p` `Arrays`
# 810. `simple-warning` `Conditions`
# 811. `sin` `Numbers`
# 812. `single-float` `Numbers`
# 813. `single-float-epsilon` `Numbers`
# 814. `single-float-negative-epsilon` `Numbers`
# 815. `sinh` `Numbers`
# 816. `sixth` `Conses`
# 817. `sleep` `Environment`
# 818. `slot-boundp` `Objects`
# 819. `slot-exists-p` `Objects`
# 820. `slot-makunbound` `Objects`
# 821. `slot-missing` `Objects`
# 822. `slot-unbound` `Objects`
# 823. `slot-value` `Objects`
# 824. `software-type` `Environment`
# 825. `software-version` `Environment`
# 826. `some` `Data and Control Flow`
# 827. `sort` `Sequences`
# 828. `space`: 见`optimize`.
# 829. `special` `Evaluation and Compilation`
# 830. `special-operator-p` `Evaluation and Compilation`
# 831. `speed`: 见`optimize`.
# 832. `sqrt` `Numbers`
# 833. `stable-sort` `Sequences`
# 834. `standard`: 内置的标准方法组合类型.
# 835. `standard-char` `Characters`
# 836. `standard-char-p` `Characters`
# 837. `standard-class` `Types and Classes`
# 838. `standard-generic-function` `Types and Classes`
# 839. `standard-method` `Types and Classes`
# 840. `standard-object` `Types and Classes`
# 841. `step` `Environment`
# 842. `storage-condition` `Conditions`
# 843. `store-value` `Conditions`
# 844. `stream` `Streams`
# 845. `stream-element-type` `Streams`
# 846. `stream-error` `Streams`
# 847. `stream-error-stream` `Streams`
# 848. `stream-external-format` `Streams`
# 849. `streamp` `Streams`
# 850. `string` `Strings`
# 851. `string-capitalize` `Strings`
# 852. `string-downcase` `Strings`
# 853. `string-equal` `Strings`
# 854. `string-greaterp` `Strings`
# 855. `string-left-trim` `Strings`
# 856. `string-lessp` `Strings`
# 857. `string-not-equal` `Strings`
# 858. `string-not-greaterp` `Strings`
# 859. `string-not-lessp` `Strings`
# 860. `string-right-trim` `Strings`
# 861. `string-stream` `Streams`
# 862. `string-trim` `Strings`
# 863. `string-upcase` `Strings`
# 864. `string/=` `Strings`
# 865. `string<` `Strings`
# 866. `string<=` `Strings`
# 867. `string=` `Strings`
# 868. `string>` `Strings`
# 869. `string>=` `Strings`
# 870. `stringp` `Strings`
# 871. `structure`: 见`documentation`.
# 872. `structure-class` `Types and Classes`
# 873. `structure-object` `Types and Classes`
# 874. `style-warning` `Conditions`
# 875. `sublis` `Conses`
# 876. `subseq` `Sequences`
# 877. `subsetp` `Conses`
# 878. `subst` `Conses`
# 879. `subst-if` `Conses`
# 880. `subst-if-not` `Conses`
# 881. `substitute` `Sequences`
# 882. `substitute-if` `Sequences`
# 883. `substitute-if-not` `Sequences`
# 884. `subtypep` `Types and Classes`
# 885. `svref` `Arrays`
# 886. `sxhash` `Hash Tables`
# 887. `symbol` `Symbols`
# 888. `symbol-function` `Symbols`
# 889. `symbol-macrolet` `Evaluation and Compilation`

> "Special Operator"

**Syntax**:

```
symbol-macrolet ( (symbol expansion)* ) declaration* form*
=> result*
```

**Arguments and Values**:

- `symbol`: 一个符号
- `expansion`: 一个形式
- `declaration`: 一个`decalre`表达式, 不被求值
- `forms`: 一个隐式的`progn`
- `results`: `forms`返回的值

**Description**:

`symbol-macrolet`提供了影响 **符号的宏扩展环境** 的机制.

`symbol-macrolet`在词法上, 为每个由`symbol`命名的符号宏建立展开函数. 符号宏的展开函数唯一可以保证的属性是, 当被应用在形式和环境时, 返回正确的展开(展开在概念上存储在展开函数中还是环境中是依赖于实现的).

`symbol-macrolet`的词法作用域中对`symbol`作为变量的引用, 被使用正常的宏展开过程处理, 见3.1.2.1.1 符号作为形式. 符号宏的展开受与调用符号宏相同的词法环境中进一步的宏展开影响, 跟常规宏一样.

`let`中的`declaration`在这里也可使用, 有一个例外: 如果用`special`声明一个已用`symbol-macrolet`定义的符号时, `symbol-macrolet`发出错误信号.

当`symbol-macrolet`形式中的`forms`被展开时, 使用`setq`设置指定变量的值时被视为是`setf`. `psetq`一个定义为符号宏的符号时, 被视为是`psetf`, `multiple-value-setq`被视为是`values`上调用`setf`.

`symbol-macrolet`的使用可以被`let`遮盖. 换种方式说, `symbol-macrolet`只在`forms`周围的`symbol`词法绑定作用域中替换`symbol`的出现.

**Examples**:

```
;;; The following is equivalent to
;;;   (list 'foo (let ((x 'bar)) x)),
;;; not
;;;   (list 'foo (let (('foo 'bar)) 'foo))
 (symbol-macrolet ((x 'foo))
   (list x (let ((x 'bar)) x))) ;被let遮盖
=>  (foo bar)
NOT=>  (foo foo)

 (symbol-macrolet ((x '(foo x)))
   (list x))
=>  ((FOO X))
```

**Affected By**: 无.

**Exceptional Situations**:

如果尝试绑定定义为 **全局变量** 的符号, 发出类型为`program-error`的错误信号.

如果`declaration`中包含`special`声明, 使用了被`symbol-macrolet`绑定的符号, 发出类型为`program-error`的错误信号.

**See Also**:

with-slots, macroexpand

**Notes**:

特殊形式`symbol-macrolet`是实现`macroexpand`的基本机制.

如果一个`symbol-macrolet`形式是顶级形式, `forms`也按顶级形式处理. 见3.2.3 文件编译.

# 890. `symbol-name` `Symbols`
# 891. `symbol-package` `Symbols`
# 892. `symbol-plist` `Symbols`
# 893. `symbol-value` `Symbols`
# 894. `symbolp` `Symbols`
# 895. `synonym-stream` `Streams`
# 896. `synonym-stream-symbol` `Streams`
# 897. `t` `Data and Control Flow` `Types and Classes`
# 898. `tagbody` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
tagbody {tag | statement}* => nil
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 899. `tailp` `Conses`
# 900. `tan` `Numbers`
# 901. `tanh` `Numbers`
# 902. `tenth` `Conses`

> "Accessor"

**Syntax**:

```
first list => object
second list => object
third list => object
fourth list => object
fifth list => object
sixth list => object
seventh list => object
eighth list => object
ninth list => object
tenth list => object
(setf (first list) new-object)
(setf (second list) new-object)
(setf (third list) new-object)
(setf (fourth list) new-object)
(setf (fifth list) new-object)
(setf (sixth list) new-object)
(setf (seventh list) new-object)
(setf (eighth list) new-object)
(setf (ninth list) new-object)
(setf (tenth list) new-object)
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 903. `terpri` `Streams`

`terpri`, `fresh-line`

**Syntax**:

```
terpri &optional output-stream => nil

fresh-line &optional output-stream => generalized-boolean
```

**Arguments and Values**:

output-stream

输出流指示器. 默认为标准输出.

generalized-boolean

通用的布尔值.

**Description**:

**Examples**:

**Side Effects**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 904. `the` `Evaluation and Compilation`

> "Special Operator"

**Syntax**:

```
the value-type form => result*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 905. `third` `Conses`
# 906. `throw` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
throw tag result-form =>|
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 907. `time` `Environment`
# 908. `trace` `Environment`
# 909. `translate-logical-pathname` `Filenames`
# 910. `translate-pathname` `Filenames`
# 911. `tree-equal` `Conses`
# 912. `truename` `Files`
# 913. `truncate` `Numbers`
# 914. `two-way-stream` `Streams`
# 915. `two-way-stream-input-stream` `Streams`
# 916. `two-way-stream-output-stream` `Streams`
# 917. `type` `Evaluation and Compilation`
# 918. `type-error` `Types and Classes`
# 919. `type-error-datum` `Types and Classes`
# 920. `type-error-expected-type` `Types and Classes`
# 921. `type-of` `Types and Classes`
# 922. `typecase` `Data and Control Flow`
# 923. `typep` `Types and Classes`
# 924. `unbound-slot` `Objects`
# 925. `unbound-slot-instance` `Objects`
# 926. `unbound-variable` `Symbols`
# 927. `undefined-function` `Data and Control Flow`
# 928. `unexport` `Packages`
# 929. `unintern` `Packages`
# 930. `union` `Conses`
# 931. `unless` `Data and Control Flow`
# 932. `unread-char` `Streams`
# 933. `unsigned-byte` `Numbers`
# 934. `untrace` `Environment`
# 935. `unuse-package` `Packages`
# 936. `unwind-protect` `Data and Control Flow`

> "Special Operator"

**Syntax**:

```
unwind-protect protected-form cleanup-form* => result*
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**:

# 937. `update-instance-for-different-class` `Objects`
# 938. `update-instance-for-redefined-class` `Objects`
# 939. `upgraded-array-element-type` `Arrays`
# 940. `upgraded-complex-part-type` `Numbers`
# 941. `upper-case-p` `Characters`
# 942. `use-package` `Packages`
# 943. `use-value` `Conditions`
# 944. `user-homedir-pathname` `Environment`
# 945. `values` `Data and Control Flow` `Types and Classes`
# 946. `values-list` `Data and Control Flow`
# 947. `variable`: 见`documentation`.
# 948. `vector` `Arrays`
# 949. `vector-pop` `Arrays`
# 950. `vector-push` `Arrays`
# 951. `vector-push-extend` `Arrays`
# 952. `vectorp` `Arrays`
# 953. `warn` `Conditions`
# 954. `warning` `Conditions`
# 955. `when` `Data and Control Flow`

> "Macro"

**Syntax**:

```
when test-form form* => result*
unless test-form form* => result*
```

**Arguments and Values**:

- `test-form`: 一个形式
- `forms`: 一个隐式的`progn`
- `result`: 在`when`形式中, 如果`test-form`求值为true, 或在`unless`形式中`test-form`求值为false, 返回`forms`的求值结果; 其他情况返回`nil`

**Description**:

`when`和`unless`允许依赖于单个`test-form`执行`forms`.

在`when`形式中, 如果`test-form`求值为true, `forms`按 **从左至右** 的顺序求值, `forms`返回的结果作为`when`形式的返回结果. 否则, 如果`test-form`求值为false, `forms`不被求值, `when`形式返回`nil`.

在`unless`形式中, 如果`test-form`求值为false, `forms`按 **从左至右** 的顺序求值, `forms`返回的结果作为`unless`形式的返回结果. 否则, 如果`test-form`求值为true, `forms`不被求值, `unless`形式返回`nil`.

**Examples**:

```lisp
(when t 'hello) =>  HELLO
(unless t 'hello) =>  NIL

(when nil 'hello) =>  NIL
(unless nil 'hello) =>  HELLO

(when t) =>  NIL
(unless nil) =>  NIL

(when t (prin1 1) (prin1 2) (prin1 3))
>>  123
=>  3

(unless t (prin1 1) (prin1 2) (prin1 3)) =>  NIL
(when nil (prin1 1) (prin1 2) (prin1 3)) =>  NIL
(unless nil (prin1 1) (prin1 2) (prin1 3))
>>  123
=>  3

(let ((x 3))
(list
			;;1: (4)
			(when (oddp x) (incf x) (list x))
			;;2: NIL - 不执行(incf x) (list x)
			(when (oddp x) (incf x) (list x))
			;;3: (5)
			(unless (oddp x) (incf x) (list x))
			;;4: NIL - 不执行(incf x) (list x)
			(unless (oddp x) (incf x) (list x))

			;;5: 6
			(if (oddp x) (incf x) (list x))
			;;6: (6)
			(if (oddp x) (incf x) (list x))
			;;7: 7
			(if (not (oddp x)) (incf x) (list x))
			;;8: (7)
			(if (not (oddp x)) (incf x) (list x))))
=>  ((4) NIL (5) NIL 6 (6) 7 (7))
```

**Affected By**: 无.

**Exceptional Situations**: 无.

**See Also**:

`and`, `cond`, `if`, `or`

**Notes**:

```lisp
(when test {form}+) ==  (and test (progn {form}+))
(when test {form}+) ==  (cond (test {form}+))
(when test {form}+) ==  (if test (progn {form}+) nil)
(when test {form}+) ==  (unless (not test) {form}+)

(unless test {form}+) ==  (cond ((not test) {form}+))
(unless test {form}+) ==  (if test nil (progn {form}+))
(unless test {form}+) ==  (when (not test) {form}+)
```

# 956. `wild-pathname-p` `Filenames`
# 957. `with-accessors` `Objects`
# 958. `with-compilation-unit` `System`
# 959. `with-condition-restarts` `Conditions`
# 960. `with-hash-table-iterator` `Hash Tables`
# 961. `with-input-from-string` `Streams`
# 962. `with-open-file` `Streams`
# 963. `with-open-stream` `Streams`
# 964. `with-output-to-string` `Streams`
# 965. `with-package-iterator` `Packages`
# 966. `with-simple-restart` `Conditions`
# 967. `with-slots` `Objects`
# 968. `with-standard-io-syntax` `Reader`
# 969. `write` `Printer`
# 970. `write-byte` `Streams`
# 971. `write-char` `Streams`
# 972. `write-line` `Streams`
# 973. `write-sequence` `Streams`
# 974. `write-string` `Printer` `Streams`
# 975. `write-to-string` `Printer`
# 976. `y-or-n-p` `Streams`
# 977. `yes-or-no-p` `Streams`
# 978. `zerop` `Numbers`

> "Function"

**Syntax**:

```
zerop number => generalized-boolean
```

**Arguments and Values**:

**Description**:

**Examples**:

**Affected By**:

**Exceptional Situations**:

**See Also**:

**Notes**: