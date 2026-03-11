(import
  (io simple)
  (sicp))

(comments "procedures as arguments")
(define (cube x) (* x x x))

(define (sum-integers a b)
  (if (> a b)
    0
    (+ a (sum-integers (+ a 1) b))))

(define (sum-cubes a b)
  (if (> a b)
    0
    (+ (cube a) (sum-cubes (+ a 1) b))))

; extract common patterns
(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
      (sum term (next a) next b))))

(let ()
  (define (inc n) (+ n 1))
  (define (sum-cubes a b)
    (sum cube a inc b))
  (define (identity x) x)
  (define (sum-integers a b)
    (sum identity a inc b))
    
  (prs
    (sum-cubes 1 10)
    (sum-integers 1 10)))

(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))

(prs (* 8 (pi-sum 1 1000)))

(define (integral f a b dx)
  (define (add-dx x)
    (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
    dx))
(prs
  (integral cube 0 1 0.01)
  (integral cube 0 1 0.001))

(comments "construct procedures using lambda")
(prs
  (lambda (x) (+ x 4))
  (lambda (x) (/ 1.0 (* x (+ x 2)))))

(let ()
  (define (pi-sum a b)
    (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
      a
      (lambda (x) (+ x 4))
      b))
  (define (integral f a b dx)
    (* (sum f
         (+ a (/ dx 2.0))
         (lambda (x) (+ x dx))
         b)
      dx))
  (prs 
    (* 8 (pi-sum 1 1000))
    (integral cube 0 1 0.01)))

(prs
  ((lambda (x y z) (+ x y (square z))) 1 2 3))

; f(x,y) = x(1+xy)^2 + y(1-y) + (1+xy)(1-y)
; a = 1+xy
; b = 1-y
; f(x,y) = xa^2 + yb + ab
(define (f x y)
  (let ([a (+ 1 (* x y))]
        [b (- 1 y)])
    (+ (* x (square a)
      (* y b)
      (* a b)))))
(prs (f 1 2))

(comments "procedure as general methods")
; find roots of equations by the half-interval method
(define (search f neg-point pos-point)
  (define (average p1 p2)
    (/ (+ p1 p2) 2))
  (define (close-enough? x y)
    (< (abs (- x y)) 0.001))
  (let ([midpoint (average neg-point pos-point)])
    (if (close-enough? neg-point pos-point)
      midpoint
      (let ([test-value (f midpoint)])
        (cond
          [(positive? test-value)
           (search f neg-point midpoint)]
          [(negative? test-value)
           (search f midpoint pos-point)]
          [else midpoint])))))

(define (half-interval-method f a b)
  (let ([a-value (f a)]
        [b-value (f b)])
    (cond
      [(and (negative? a-value) (positive? b-value))
       (search f a b)]
      [(and (negative? b-value) (positive? a-value))
       (search f b a)]
      [else
       (error "Values are not of opposite sign" a b)])))

(prs
  (half-interval-method sin 2.0 4.0)
  (half-interval-method
    (lambda (x) (- (* x x x) (* 2 x) 3))
    1.0
    2.0))

; find fixed points of functions
; f(x), f(f(x)), f(f(f(x))), ...
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ([next (f guess)])
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

(prs
  (fixed-point cos 1.0)
  (fixed-point
    (lambda (y) (+ (sin y) (cos y)))
    1.0))

; square root: x = y^2
; fixed-point: y => x/y
; fixed-point2: y => (y + x/y) / 2
(let ()
  ; may not converge
  #;(define (sqrt x)
    (fixed-point
      (lambda (y) (/ y x))
      1.0))
  
  (define (average x y)
    (/ (+ x y) 2))
  (define (sqrt x)
    (fixed-point
      (lambda (y) (average y (/ x y)))
      1.0))
      
  (prs
    (sqrt (+ 100 37))
    (sqrt (+ (sqrt 2) (sqrt 3)))))

(comments "procedures as returned values")
(let ()
  (define (average x y)
    (/ (+ x y) 2))
  (define (average-damp f)
    (lambda (x) (average x (f x))))
  (define (sqrt x)
    (fixed-point (average-damp (lambda (y) (/ x y)))
      1.0))
  
  (prs
    (sqrt (+ 100 37))
    (sqrt (+ (sqrt 2) (sqrt 3)))))

; Newton's method
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
     dx)))
(define dx 0.00001)
(define (cube x) (* x x x))
(prs ((deriv cube) 5))
(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(let ()
  (define (sqrt x)
    (newtons-method (lambda (y) (- (square y) x))
      1.0))
  
  (prs
    (sqrt (+ 100 37))
    (sqrt (+ (sqrt 2) (sqrt 3)))))

; asbtractions and first-class procedures
(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(let ()
  (define (average x y)
    (/ (+ x y) 2))
  (define (average-damp f)
    (lambda (x) (average x (f x))))
  (define (sqrt x)
    (fixed-point-of-transform
      (lambda (y) (/ x y))
      average-damp
      1.0))
  
  (prs
    (sqrt (+ 100 37))
    (sqrt (+ (sqrt 2) (sqrt 3)))))

(exit)