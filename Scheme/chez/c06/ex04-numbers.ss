(import (io simple))

(comments "exact?")
(prs
  (exact? 1) 
  (exact? -15/16) 
  (exact? 2.01) 
  (exact? #i77) 
  (exact? #i2/3) 
  (exact? 1.0-2i) 
)

(comments "inexact?")
(prs
  (inexact? -123) 
  (inexact? #i123) 
  (inexact? 1e23) 
  (inexact? +i) 
)

(comments "=, <, >, <= >=")
(prs
  (= 7 7) 
  (= 7 9) 

  (< 2e3 3e2) 
  (<= 1 2 3 3 4 5) 
  (<= 1 2 3 4 5) 

  (> 1 2 2 3 3 4) 
  (>= 1 2 2 3 3 4) 

  (= -1/2 -0.5) 
  (= 2/3 .667) 
  (= 7.2+0i 7.2) 
  (= 7.2-3i 7) 

  (< 1/2 2/3 3/4) 
  (> 8 4.102 2/3 -5) 

  (let ([x 0.218723452])
    (< 0.210 x 0.220)) 

  (let ([i 1] [v (vector 'a 'b 'c)])
    (< -1 i (vector-length v))) 

  (apply < '(1 2 3 4)) 
  (apply > '(4 3 3 2)) 

  (= +nan.0 +nan.0) 
  (< +nan.0 +nan.0) 
  (> +nan.0 +nan.0) 
  (>= +inf.0 +nan.0) 
  (>= +nan.0 -inf.0) 
  (> +nan.0 0.0) 
)

(comments "+")
(prs
  (+) 
  (+ 1 2) 
  (+ 1/2 2/3) 
  (+ 3 4 5) 
  (+ 3.0 4) 
  (+ 3+4i 4+3i) 
  (apply + '(1 2 3 4 5)) 
)

(comments "-")
(prs
  (- 3) 
  (- -2/3) 
  (- 4 3.0) 
  (- 3.25+4.25i 1/4+1/4i) 
  (- 4 3 2 1) 
)

(comments "*")
(prs
  (*) 
  (* 3.4) 
  (* 1 1/2) 
  (* 3 4 5.5) 
  (* 1+2i 3+4i) 
  (apply * '(1 2 3 4 5)) 
)

(comments "/")
(prs
  (/ -17) 
  (/ 1/2) 
  (/ .5) 
  (/ 3 4) 
  (/ 3.0 4) 
  (/ -5+10i 3+4i) 
  (/ 60 5 4 3 2) 
)

(comments "zero?")
(prs
  (zero? 0) 
  (zero? 1) 
  (zero? (- 3.0 3.0)) 
  (zero? (+ 1/2 1/2)) 
  (zero? 0+0i) 
  (zero? 0.0-0.0i) 
)

(comments "positive?")
(prs
  (positive? 128) 
  (positive? 0.0) 
  (positive? 1.8e-15) 
  (positive? -2/3) 
  ;(positive? .001-0.0i) ; 0.001-0.0i is not a real number
)

(comments "negative?")
(prs
  (negative? -65) 
  (negative? 0) 
  (negative? -0.0121) 
  (negative? 15/16) 
  ;(negative? -7.0+0.0i) ; -7.0+0.0i is not a real number
)

(comments "even?, odd?")
(prs
  (even? 0) 
  (even? 1) 
  (even? 2.0) 
  (even? -120762398465) 
  ;(even? 2.0+0.0i) ; 2.0+0.0i is not an integer

  (odd? 0) 
  (odd? 1) 
  (odd? 2.0) 
  (odd? -120762398465) 
  ;(odd? 2.0+0.0i) ; 2.0+0.0i is not an integer
)

(comments "finite?, infinite?, nan?")
(prs
  (finite? 2/3) 
  (infinite? 2/3) 
  (nan? 2/3) 

  (finite? 3.1415) 
  (infinite? 3.1415) 
  (nan? 3.1415) 

  (finite? +inf.0) 
  (infinite? -inf.0) 
  (nan? -inf.0) 

  (finite? +nan.0) 
  (infinite? +nan.0) 
  (nan? +nan.0) 
)

(comments "quotient, remainder, modulo")
(prs
  (quotient 45 6) 
  (quotient 6.0 2.0) 
  (quotient 3.0 -2) 

  (remainder 16 4) 
  (remainder 5 2) 
  (remainder -45.0 7) 
  (remainder 10.0 -3.0) 
  (remainder -17 -9) 

  (modulo 16 4) 
  (modulo 5 2) 
  (modulo -45.0 7) 
  (modulo 10.0 -3.0) 
  (modulo -17 -9) 
)

(comments "div, mod, div-and-mod")
(prs
  (div 17 3) 
  (mod 17 3) 
  (div -17 3) 
  (mod -17 3) 
  (div 17 -3) 
  (mod 17 -3) 
  (div -17 -3) 
  (mod -17 -3) 

  (let-values ([(d m) (div-and-mod 17.5 3)])
    (list d m)) 
)

(comments "div0, mod0, div0-and-mod0")
(prs
  (div0 17 3) 
  (mod0 17 3) 
  (div0 -17 3) 
  (mod0 -17 3) 
  (div0 17 -3) 
  (mod0 17 -3) 
  (div0 -17 -3) 
  (mod0 -17 -3) 

  (let-values ([(d m) (div0-and-mod0 17.5 3)])
    (list d m)) 
)

(comments "truncate")
(prs
  (truncate 19) 
  (truncate 2/3) 
  (truncate -2/3) 
  (truncate 17.3) 
  (truncate -17/2) 
)

(comments "floor")
(prs
  (floor 19) 
  (floor 2/3) 
  (floor -2/3) 
  (floor 17.3) 
  (floor -17/2) 
)

(comments "ceiling")
(prs
  (ceiling 19) 
  (ceiling 2/3) 
  (ceiling -2/3) 
  (ceiling 17.3) 
  (ceiling -17/2) 
)

(comments "round")
(prs
  (round 19) 
  (round 2/3) 
  (round -2/3) 
  (round 17.3) 
  (round -17/2) 
  (round 2.5) 
  (round 3.5) 
)

(comments "abs")
(prs
  (abs 1) 
  (abs -3/4) 
  (abs 1.83) 
  (abs -0.093) 
)

(comments "max")
(prs
  (max 4 -7 2 0 -6) 
  (max 1/2 3/4 4/5 5/6 6/7) 
  (max 1.5 1.3 -0.3 0.4 2.0 1.8) 
  (max 5 2.0) 
  (max -5 -2.0) 
  (let ([ls '(7 3 5 2 9 8)])
    (apply max ls)) 
)

(comments "min")
(prs
  (min 4 -7 2 0 -6) 
  (min 1/2 3/4 4/5 5/6 6/7) 
  (min 1.5 1.3 -0.3 0.4 2.0 1.8) 
  (min 5 2.0) 
  (min -5 -2.0) 
  (let ([ls '(7 3 5 2 9 8)])
    (apply min ls)) 
)

(comments "gcd")
(prs
  (gcd) 
  (gcd 34) 
  (gcd 33.0 15.0) 
  (gcd 70 -42 28) 
)

(comments "lcm")
(prs
  (lcm) 
  (lcm 34) 
  (lcm 33.0 15.0) 
  (lcm 70 -42 28) 
  (lcm 17.0 0) 
)

(comments "expt")
(prs
  (expt 2 10) 
  (expt 2 -10) 
  (expt 2 -10.0) 
  (expt -1/2 5) 
  (expt 3.0 3) 
  (expt +i 2) 
)

(comments "inexact")
(prs
  (inexact 3) 
  (inexact 3.0) 
  (inexact -1/4) 
  (inexact 3+4i) 
  (inexact (expt 10 20)) 
)

(comments "exact")
(prs
  (exact 3.0) 
  (exact 3) 
  (exact -.25) 
  (exact 3.0+4.0i) 
  (exact 1e20) 
)

(comments "rationalize")
(prs
  (rationalize 3/10 1/10) 
  (rationalize .3 1/10) 
  (eqv? (rationalize .3 1/10) #i1/3) 
)

(comments "numerator, denominator")
(prs
  (numerator 9) 
  (numerator 9.0) 
  (numerator 0.0) 
  (numerator 2/3) 
  (numerator -9/4) 
  (numerator -2.25) 

  (denominator 9) 
  (denominator 9.0) 
  (denominator 0) 
  (denominator 0.0) 
  (denominator 2/3) 
  (denominator -9/4) 
  (denominator -2.25) 
)

(comments "make-rectangular, real-part, imag-part")
(prs
  (make-rectangular -2 7) 
  (make-rectangular 2/3 -1/2) 
  (make-rectangular 3.2 5.3) 

  (real-part 3+4i) 
  (real-part -2.3+0.7i) 
  (real-part -i) 
  (real-part 17.2) 
  (real-part -17/100) 

  (imag-part 3+4i) 
  (imag-part -2.3+0.7i) 
  (imag-part -i) 
  (imag-part -2.5) 
  (imag-part -17/100) 
)

(comments "make-polar, angle, magnitude")
(prs
  (make-polar 2 0) 
  (make-polar 2.0 0.0) 
  (make-polar 1.0 (asin -1.0)) 
  (eqv? (make-polar 7.2 -0.588) 7.2@-0.588) 

  (angle 7.3@1.5708) 
  (angle 5.2) 
  (magnitude 1) 
  (magnitude -3/4) 
  (magnitude 1.83) 
  (magnitude -0.093) 
  (magnitude 3+4i) 
  (magnitude 7.25@1.5708) 
)

(comments "sqrt")
(prs
  (sqrt 16) 
  (sqrt 1/4) 
  (sqrt 4.84) 
  (sqrt -4.84) 
  (sqrt 3+4i) 
  (sqrt -3.0-4.0i) 
)

(comments "exact-integer-sqrt")
(prs
  (let-values ([(s r) (exact-integer-sqrt 0)])
    (list s r))
  (let-values ([(s r) (exact-integer-sqrt 9)])
    (list s r))
  (let-values ([(s r) (exact-integer-sqrt 19)])
    (list s r))
)

(comments "exp")
(prs
  (exp 0.0) 
  (exp 1.0) 
  (exp -.5) 
)

(comments "log")
(prs
  (log 1.0) 
  (log (exp 1.0)) 
  (/ (log 100) (log 10)) 
  (log (make-polar (exp 2.0) 1.0)) 

  (log 100.0 10.0) 
  (log .125 2.0) 
)

(comments "sin, cos, tan")
(prs
  (sin 0.0) 
  (cos 0.0) 
  (tan 0.0) 
)

(comments "bitwise-not, bitwise-and, bitwise-ior, bitwise-xor")
(prs
  (bitwise-not 0) 
  (bitwise-not 3) 

  (bitwise-and #b01101 #b00111) 
  (bitwise-ior #b01101 #b00111) 
  (bitwise-xor #b01101 #b00111) 
)

(comments "bitwise-if")
(prs
  (bitwise-if #b101010 #b111000 #b001100) 
)

(comments "bitwise-bit-count")
(prs
  (bitwise-bit-count #b00000) 
  (bitwise-bit-count #b00001) 
  (bitwise-bit-count #b00100) 
  (bitwise-bit-count #b10101) 

  (bitwise-bit-count -1) 
  (bitwise-bit-count -2) 
  (bitwise-bit-count -4) 
)

(comments "bitwise-length")
(prs
  (bitwise-length #b00000) 
  (bitwise-length #b00001) 
  (bitwise-length #b00100) 
  (bitwise-length #b00110) 

  (bitwise-length -1) 
  (bitwise-length -6) 
  (bitwise-length -9) 
)

(comments "bitwise-first-bit-set")
(prs
  (bitwise-first-bit-set #b00000) 
  (bitwise-first-bit-set #b00001) 
  (bitwise-first-bit-set #b01100) 

  (bitwise-first-bit-set -1) 
  (bitwise-first-bit-set -2) 
  (bitwise-first-bit-set -3) 
)

(comments "bitwise-bit-set?")
(prs
  (bitwise-bit-set? #b01011 0) 
  (bitwise-bit-set? #b01011 2) 

  (bitwise-bit-set? -1 0) 
  (bitwise-bit-set? -1 20) 
  (bitwise-bit-set? -3 1) 

  (bitwise-bit-set? 0 5000) 
  (bitwise-bit-set? -1 5000) 
)

(comments "bitwise-copy-bit")
(prs
  (bitwise-copy-bit #b01110 0 1) 
  (bitwise-copy-bit #b01110 2 0) 
)

(comments "bitwise-bit-field")
(prs
  (bitwise-bit-field #b10110 0 3) 
  (bitwise-bit-field #b10110 1 3) 
  (bitwise-bit-field #b10110 2 3) 
  (bitwise-bit-field #b10110 3 3) 
)

(comments "bitwise-copy-bit-field")
(prs
  (bitwise-copy-bit-field #b10000 0 3 #b10101) 
  (bitwise-copy-bit-field #b10000 1 3 #b10101) 
  (bitwise-copy-bit-field #b10000 2 3 #b10101) 
  (bitwise-copy-bit-field #b10000 3 3 #b10101) 
)

(comments "bitwise-arithmetic-shift-right, bitwise-arithmetic-shift-left")
(prs
  (bitwise-arithmetic-shift-right #b10000 3) 
  (bitwise-arithmetic-shift-right -1 1) 
  (bitwise-arithmetic-shift-right -64 3) 

  (bitwise-arithmetic-shift-left #b00010 2) 
  (bitwise-arithmetic-shift-left -1 2) 
)

(comments "bitwise-arithmetic-shift")
(prs
  (bitwise-arithmetic-shift #b10000 -3) 
  (bitwise-arithmetic-shift -1 -1) 
  (bitwise-arithmetic-shift -64 -3) 
  (bitwise-arithmetic-shift #b00010 2) 
  (bitwise-arithmetic-shift -1 2) 
)

(comments "bitwise-rotate-bit-field")
(prs
  (bitwise-rotate-bit-field #b00011010 0 5 3) 
  (bitwise-rotate-bit-field #b01101011 2 7 3) 
)

(comments "bitwise-reverse-bit-field")
(prs
  (bitwise-reverse-bit-field #b00011010 0 5) 
  (bitwise-reverse-bit-field #b01101011 2 7) 
)

(comments "string->number")
(prs
  (string->number "0") 
  (string->number "3.4e3") 
  (string->number "#x#e-2e2") 
  (string->number "#e-2e2" 16) 
  (string->number "#i15/16") 
  (string->number "10" 16) 
)

(comments "number->string")
(prs
  (number->string 3.4) 
  (number->string 1e2) 
  (number->string 1e-23) 
  (number->string -7/2) 
  (number->string 220/9 16) 
)

(exit)