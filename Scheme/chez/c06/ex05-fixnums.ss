(import (io simple))

(comments "fixnum?")
(prs
  (fixnum? 0) 
  (fixnum? -1) 
  (fixnum? (- (expt 2 23))) 
  (fixnum? (- (expt 2 23) 1)) 
)

(comments "least-fixnum, greatest-fixnum")
(prs
  (fixnum? (- (least-fixnum) 1)) 
  (fixnum? (least-fixnum)) 
  (fixnum? (greatest-fixnum)) 
  (fixnum? (+ (greatest-fixnum) 1)) 
)

(comments "fixnum-width")
(let ([w (fixnum-width)])
  (prs
    (= (least-fixnum) (- (expt 2 (- w 1)))) 
    (= (greatest-fixnum) (- (expt 2 (- w 1)) 1)) 
    (>= w 24))
)

(comments "fx=?, fx<?, fx>?, fx<=?, fx>=?")
(prs
  (fx=? 0 0) 
  (fx=? -1 1) 
  (fx<? (least-fixnum) 0 (greatest-fixnum)) 
  (let ([x 3]) (fx<=? 0 x 9)) 
  (fx>? 5 4 3 2 1) 
  (fx<=? 1 3 2) 
  (fx>=? 0 0 (least-fixnum)) 
)

(comments "fxzero?, fxpositive?, fxnegative?")
(prs
  (fxzero? 0) 
  (fxzero? 1) 

  (fxpositive? 128) 
  (fxpositive? 0) 
  (fxpositive? -1) 

  (fxnegative? -65) 
  (fxnegative? 0) 
  (fxnegative? 1) 
)

(comments "fxeven?, fxodd?")
(prs
  (fxeven? 0) 
  (fxeven? 1) 
  (fxeven? -1) 
  (fxeven? -10) 

  (fxodd? 0) 
  (fxodd? 1) 
  (fxodd? -1) 
  (fxodd? -10) 
)

(comments "fxmin, fxmax")
(prs
  (fxmin 4 -7 2 0 -6) 

  (let ([ls '(7 3 5 2 9 8)])
    (apply fxmin ls)) 

  (fxmax 4 -7 2 0 -6) 

  (let ([ls '(7 3 5 2 9 8)])
    (apply fxmax ls)) 
)

(comments "fx+, fx-, fx*")
(prs
  (fx+ -3 4) 

  (fx- 3) 
  (fx- -3 4) 

  (fx* -3 4) 
)

(comments "fxdiv, fxmod, fxdiv-and-mod")
(prs
  (fxdiv 17 3) 
  (fxmod 17 3) 
  (fxdiv -17 3) 
  (fxmod -17 3) 
  (fxdiv 17 -3) 
  (fxmod 17 -3) 
  (fxdiv -17 -3) 
  (fxmod -17 -3) 

  (let-values ([(d m) (fxdiv-and-mod 17 3)])
    (list d m))
)

(comments "fxdiv0, fxmod0, fxdiv0-and-mod0")
(prs
  (fxdiv0 17 3) 
  (fxmod0 17 3) 
  (fxdiv0 -17 3) 
  (fxmod0 -17 3) 
  (fxdiv0 17 -3) 
  (fxmod0 17 -3) 
  (fxdiv0 -17 -3) 
  (fxmod0 -17 -3) 

  (let-values ([(d m) (fxdiv0-and-mod0 17 3)])
    (list d m))
)

(comments "fxnot, fxand, fxior")
(prs
  (fxnot 0) 
  (fxnot 3) 

  (fxand #b01101 #b00111) 
  (fxior #b01101 #b00111) 
  (fxxor #b01101 #b00111) 
)

(comments "fxif")
(prs
  (fxif #b101010 #b111000 #b001100)
)

(comments "fxbit-count")
(prs
  (fxbit-count #b00000) 
  (fxbit-count #b00001) 
  (fxbit-count #b00100) 
  (fxbit-count #b10101) 

  (fxbit-count -1) 
  (fxbit-count -2) 
  (fxbit-count -4) 
)

(comments "fxlength")
(prs
  (fxlength #b00000) 
  (fxlength #b00001) 
  (fxlength #b00100) 
  (fxlength #b00110) 

  (fxlength -1) 
  (fxlength -6) 
  (fxlength -9) 
)

(comments "fxfirst-bit-set")
(prs
  (fxfirst-bit-set #b00000) 
  (fxfirst-bit-set #b00001) 
  (fxfirst-bit-set #b01100) 

  (fxfirst-bit-set -1) 
  (fxfirst-bit-set -2) 
  (fxfirst-bit-set -3) 
)

(comments "fxbit-set?")
(prs
  (fxbit-set? #b01011 0) 
  (fxbit-set? #b01011 2) 

  (fxbit-set? -1 0) 
  (fxbit-set? -1 20) 
  (fxbit-set? -3 1) 
  (fxbit-set? 0 (- (fixnum-width) 1)) 
  (fxbit-set? -1 (- (fixnum-width) 1)) 
)

(comments "fxcopy-bit")
(prs
  (fxcopy-bit #b01110 0 1) 
  (fxcopy-bit #b01110 2 0) 
)

(comments "fxbit-field")
(prs
  (fxbit-field #b10110 0 3) 
  (fxbit-field #b10110 1 3) 
  (fxbit-field #b10110 2 3) 
  (fxbit-field #b10110 3 3) 
)

(comments "fxcopy-bit-field")
(prs
  (fxcopy-bit-field #b10000 0 3 #b10101) 
  (fxcopy-bit-field #b10000 1 3 #b10101) 
  (fxcopy-bit-field #b10000 2 3 #b10101) 
  (fxcopy-bit-field #b10000 3 3 #b10101) 
)

(comments "fxarithmetic-shift-right, fxarithmetic-shift-left")
(prs
  (fxarithmetic-shift-right #b10000 3) 
  (fxarithmetic-shift-right -1 1) 
  (fxarithmetic-shift-right -64 3) 

  (fxarithmetic-shift-left #b00010 2) 
  (fxarithmetic-shift-left -1 2) 
)

(comments "fxarithmetic-shift")
(prs
  (fxarithmetic-shift #b10000 -3) 
  (fxarithmetic-shift -1 -1) 
  (fxarithmetic-shift -64 -3) 
  (fxarithmetic-shift #b00010 2) 
  (fxarithmetic-shift -1 2) 
)

(comments "fxrotate-bit-field")
(prs
  (fxrotate-bit-field #b00011010 0 5 3) 
  (fxrotate-bit-field #b01101011 2 7 3) 
)

(comments "fxreverse-bit-field")
(prs
  (fxreverse-bit-field #b00011010 0 5) 
  (fxreverse-bit-field #b01101011 2 7) 
)

(exit)