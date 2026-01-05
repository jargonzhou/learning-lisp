(import (io simple))

(comments "endianness")
(prs
  (endianness little)
  (endianness big)
  ; (endianness "spam") ; invalid endianness "spam"

  (symbol? (native-endianness))
)

(comments "make-bytevector")
(prs
  (make-bytevector 0)
  (make-bytevector 0 7)
  (make-bytevector 5 7)
  (make-bytevector 5 -7)
)

(comments "bytevector-length")
(prs
  (bytevector-length #vu8())
  (bytevector-length #vu8(1 2 3))
  (bytevector-length (make-bytevector 300))
)

(comments "bytevector=?")
(prs
  (bytevector=? #vu8() #vu8())
  (bytevector=? (make-bytevector 3 0) #vu8(0 0 0))
  (bytevector=? (make-bytevector 5 0) #vu8(0 0 0))
  (bytevector=? #vu8(1 127 128 255) #vu8(255 128 127 1))
)

(comments "bytevector-fill!")
(prs
  (let ([v (make-bytevector 6)])
    (bytevector-fill! v 255)
    v)

  (let ([v (make-bytevector 6)])
    (bytevector-fill! v -128)
    v)
)

(comments "bytevector-copy")
(prs
  (bytevector-copy #vu8(1 127 128 255))

  (let ([v #vu8(1 127 128 255)])
    (eq? v (bytevector-copy v)))
)

(comments "")
(let ([v1 #vu8(31 63 95 127 159 191 223 255)]
      [v2 (make-bytevector 10 0)])      
  (bytevector-copy! v1 2 v2 1 4)
  (prs v2)
  
  (bytevector-copy! v1 5 v2 7 3)
  (prs v2)
  
  (bytevector-copy! v2 3 v2 0 6)
  (prs v2)
  
  (bytevector-copy! v2 0 v2 1 9)
  (prs v2))

(comments "ref: u8, s8")
(prs
  (bytevector-u8-ref #vu8(1 127 128 255) 0)
  (bytevector-u8-ref #vu8(1 127 128 255) 2)
  (bytevector-u8-ref #vu8(1 127 128 255) 3)

  (bytevector-s8-ref #vu8(1 127 128 255) 0)
  (bytevector-s8-ref #vu8(1 127 128 255) 1)
  (bytevector-s8-ref #vu8(1 127 128 255) 2)
  (bytevector-s8-ref #vu8(1 127 128 255) 3)
)

(comments "set!: u8, s8")
(prs
  (let ([v (make-bytevector 5 -1)])
    (bytevector-u8-set! v 2 128)
    v)

  (let ([v (make-bytevector 4 0)])
    (bytevector-s8-set! v 1 100)
    (bytevector-s8-set! v 2 -100)
    v)
)

(comments "u8-list")
(prs
  (bytevector->u8-list (make-bytevector 0))
  (bytevector->u8-list #vu8(1 127 128 255))

  (let ([v #vu8(1 2 3 255)])
    (apply * (bytevector->u8-list v)))

  (u8-list->bytevector '())
  (u8-list->bytevector '(1 127 128 255))

  (let ([v #vu8(1 2 3 4 5)])
    (let ([ls (bytevector->u8-list v)])
      (u8-list->bytevector (map * ls ls))))
)

(comments "ref: u16, s16, u32, s32, u64, s64")
(let ([v #vu8(#x12 #x34 #xfe #x56 #xdc #xba #x78 #x98)])
  (prs
    (bytevector-u16-native-ref v 2)
    (bytevector-s16-native-ref v 2)
    (bytevector-s16-native-ref v 6)

    (bytevector-u32-native-ref v 0)
    (bytevector-s32-native-ref v 0)
    (bytevector-s32-native-ref v 4)

    (bytevector-u64-native-ref v 0)
    (bytevector-s64-native-ref v 0)))

(comments "set!: u16, s16, u32, s32, u64, s64")
(let ([v (make-bytevector 8 0)])
  (bytevector-u16-native-set! v 0 #xfe56)
  (bytevector-s16-native-set! v 2 #x-1aa)
  (bytevector-s16-native-set! v 4 #x7898)
  (prs v))


(let ([v (make-bytevector 16 0)])
  (bytevector-u32-native-set! v 0 #x1234fe56)
  (bytevector-s32-native-set! v 4 #x1234fe56)
  (bytevector-s32-native-set! v 8 #x-23458768)
  (prs v))

(let ([v (make-bytevector 24 0)])
  (bytevector-u64-native-set! v 0 #x1234fe56dcba7898)
  (bytevector-s64-native-set! v 8 #x1234fe56dcba7898)
  (bytevector-s64-native-set! v 16 #x-67874523a901cbee)
  (prs v))

(comments "ref with eness: u16, s16, u32, s32, u64, s64")
(let ([v #vu8(#x12 #x34 #xfe #x56 #xdc #xba #x78 #x98 #x9a #x76)])
  (prs
    (bytevector-u16-ref v 0 (endianness big))
    (bytevector-s16-ref v 1 (endianness big))
    (bytevector-s16-ref v 5 (endianness big))

    (bytevector-u32-ref v 2 'big)
    (bytevector-s32-ref v 3 'big)
    (bytevector-s32-ref v 4 'big)

    (bytevector-u64-ref v 0 'big)
    (bytevector-s64-ref v 1 'big)

    (bytevector-u16-ref v 0 (endianness little))
    (bytevector-s16-ref v 1 (endianness little))
    (bytevector-s16-ref v 5 (endianness little))

    (bytevector-u32-ref v 2 'little)
    (bytevector-s32-ref v 3 'little)
    (bytevector-s32-ref v 4 'little)

    (bytevector-u64-ref v 0 'little)
    (bytevector-s64-ref v 1 'little)
  ))

(comments "set! with eness: u16, s16, u32, s32, u64, s64")
(let ([v (make-bytevector 8 0)])
  (bytevector-u16-set! v 0 #xfe56 (endianness big))
  (bytevector-s16-set! v 3 #x-1aa (endianness little))
  (bytevector-s16-set! v 5 #x7898 (endianness big))
  (prs v))

(let ([v (make-bytevector 16 0)])
  (bytevector-u32-set! v 0 #x1234fe56 'little)
  (bytevector-s32-set! v 6 #x1234fe56 'big)
  (bytevector-s32-set! v 11 #x-23458768 'little)
  (prs v))

(let ([v (make-bytevector 28 0)])
  (bytevector-u64-set! v 0 #x1234fe56dcba7898 'little)
  (bytevector-s64-set! v 10 #x1234fe56dcba7898 'big)
  (bytevector-s64-set! v 19 #x-67874523a901cbee 'big)
  (prs v))

(comments "ref: uint, sint")
(let ([v #vu8(#x12 #x34 #xfe #x56 #xdc #xba #x78 #x98 #x9a #x76)])
  (prs
    (bytevector-uint-ref v 0 'big 1)
    (bytevector-uint-ref v 0 'little 1)
    (bytevector-uint-ref v 1 'big 3)
    (bytevector-uint-ref v 2 'little 7)

    (bytevector-sint-ref v 2 'big 1)
    (bytevector-sint-ref v 1 'little 6)
    (bytevector-sint-ref v 2 'little 7)

    (bytevector-sint-ref (make-bytevector 1000 -1) 0 'big 1000)))

(comments "set!: uint, sint")
(let ([v (make-bytevector 5 0)])
  (bytevector-uint-set! v 1 #x123456 (endianness big) 3)
  (prs v))

(let ([v (make-bytevector 7 -1)])
  (bytevector-sint-set! v 1 #x-8000000000 (endianness little) 5)
  (prs v))

(comments "conversion: uint-list, sint-list")
(prs 
  (bytevector->uint-list (make-bytevector 0) 'little 3)

  (let ([v #vu8(1 2 3 4 5 6)])
    (bytevector->uint-list v 'big 3))

  (let ([v (make-bytevector 80 -1)])
    (bytevector->sint-list v 'big 20))


  (uint-list->bytevector '() 'big 25)
  (sint-list->bytevector '(0 -1) 'big 3))

(define (f size)
  (let ([ls (list (- (expt 2 (- (* 8 size) 1)))
                  (- (expt 2 (- (* 8 size) 1)) 1))])
    (sint-list->bytevector ls 'little size)))
(prs (f 6))

(comments "set!: ieee")
(let ([v (make-bytevector 8 0)])
  (bytevector-ieee-single-native-set! v 0 .125)
  (bytevector-ieee-single-native-set! v 4 -3/2)
  (prs
    (list
      (bytevector-ieee-single-native-ref v 0)
      (bytevector-ieee-single-native-ref v 4)))

  (bytevector-ieee-double-native-set! v 0 1e23)
  (prs (bytevector-ieee-double-native-ref v 0))
)



(comments "set! with eness: ieee")
(let ([v (make-bytevector 10 #xc7)])
  (bytevector-ieee-single-set! v 1 .125 'little)
  (bytevector-ieee-single-set! v 6 -3/2 'big)
  (prs
    (list
      (bytevector-ieee-single-ref v 1 'little)
      (bytevector-ieee-single-ref v 6 'big))
    v)

  (bytevector-ieee-double-set! v 1 1e23 'big)
  (prs (bytevector-ieee-double-ref v 1 'big)))


(exit)