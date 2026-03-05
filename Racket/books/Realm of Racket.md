# Realm of Racket/Racket王国

code: `$RACKET_HOME/share/pkgs/realm`

# Introduction: Open Paren

# 1 Getting Started

# 2 A First Racket Program

# 3 Basics of Racket

# 4 Conditions and Decisions

`rackunit` library
```racket
(require rackunit)
```

# 4 and a Half: define define 'define

# 5 Big-Bang

```racket
(require 2htdp/universe) ; package: htdp-lib

(big-bang state-expression
  (to-draw draw-function)
  (on-tick tick-function)
  (on-key key-function)
  (stop-when stop-function optional-last-scene))
```

```racket
> (start 0 100)
```

# 6 Recursion is Easy

```racket
(struct pit (snake goos) #:transparent)
(struct snake (dir segs) #:transparent)
(struct goo (loc expire) #:transparent)
(struct posn (x y) #:transparent)
```

# 7 Land of Lambda

# 8 Mutant Structs

struct inheritance

```racket
(struct orc-world (player lom attack# target) #:transparent #:mutable)

(struct player (health agility strength) #:transparent #:mutable)

(struct monster (image [health #:mutable]) #:transparent)
(struct orc monster (club) #:transparent)
(struct hydra monster () #:transparent)
(struct slime monster (sliminess) #:transparent)
(struct brigand monster () #:transparent)
```

# 9 The Values of Loops

- for loops
```racket
for
for-each
for/list
for/fold
```

- multiple values
```racket
values
define-values
```

- `for/fold`

- more on loops
```racket
#:when

for*
for*/list
for*/fold

in-range ; return a stream

for/and
for/or
for/first
for/last
; ...
```

# 10 Dice of Doom

[Game tree - wikipedia](https://en.wikipedia.org/wiki/Game_tree)/博弈树
![tic-tac-toe](https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Tic-tac-toe-game-tree.svg/960px-Tic-tac-toe-game-tree.svg.png)

```racket
(struct dice-world (src board gt) #:transparent)
(struct game (board player moves) #:transparent)
(struct move (action gt) #:transparent)
(struct territory (index player dice x y) #:transparent)

(define (game-tree board player dice)
 ...)
```

TIC-TAC-TOE `vector`-based board implementation
```racket
#lang racket


;                                                                                          
;                                                                                          
;                                                                                          
;                                                                                          
;   ;;;;;;            ;;            ;;;;;;            ;;            ;;;;;;    ;;           
;   ;;;;;;  ;;;;;    ; ;;           ;;;;;;    ;;     ; ;;           ;;;;;;   ; ;;   ;;;;;; 
;     ;       ;;    ;   ;;            ;       ;;    ;   ;;            ;     ;   ;;  ;      
;     ;       ;;    ;                 ;      ; ;    ;                 ;     ;   ;;  ;      
;     ;       ;;    ;                 ;      ;  ;   ;                 ;     ;   ;;  ;      
;     ;       ;;    ;        ;;;;     ;      ;  ;   ;        ;;;;     ;     ;   ;;  ;;;;;  
;     ;       ;;    ;                 ;      ;;;;   ;                 ;     ;   ;;  ;      
;     ;       ;;    ;    ;            ;     ;   ;;  ;    ;            ;     ;   ;;  ;      
;     ;       ;;    ;;  ;;            ;     ;    ;  ;;  ;;            ;     ;;  ;   ;      
;     ;     ;;;;;    ;;;;             ;     ;    ;   ;;;;             ;      ;;;;   ;;;;;; 
;                                                                                          
;                                                                                          
;                                                                                          
;                                                                                          
(struct ttt (board moves) #:transparent)
(struct action (player position) #:transparent)
(struct pos (x y) #:transparent)
(struct player (sym) #:transparent)

(define SIZE 3)
(define X 'X)
(define O 'O)
(define NIL '_)
(define XP (player X))
(define OP (player O))


(define the-empty-board
  (for/vector ([i (in-range SIZE)])
    (make-vector SIZE NIL)))
(define (make-board)
  (for/vector ([i (in-range SIZE)])
    (make-vector SIZE NIL)))

(define (board-find-free-fields board)
  ; (displayln board) ; DEBUG
  (for*/vector ([i (range SIZE)]
                [j (range SIZE)]
                #:when (equal? NIL (vector-ref
                                    (vector-ref board i)
                                    j)))
    (pos i j)))
;(board-find-free-fields the-empty-board)

(define (copy-board board)
  (define b (make-board))
  (for*/vector ([i (range SIZE)]
                [j (range SIZE)])
    (vector-set! (vector-ref b i) j
                 (vector-ref (vector-ref board i) j)))
  b)

(define (board-take-field board player f)
  (define b (copy-board board))
  (vector-set! (vector-ref b (pos-x f)) (pos-y f) (player-sym player))
  b)

(define counter 0)
(define (generate-ttt-tree player1 player2)
  (define (generate-tree board player opponent)
    (let ([moves (generate-moves board player opponent)])
      (ttt board moves)))
  
  (define (generate-moves board0 player opponent)
    (define free-fields (board-find-free-fields board0))
    (when (vector-empty? free-fields)
      (set! counter (add1 counter))
      (displayln counter)) ; DEBUG - the final state
    (if (vector-empty? free-fields)
        empty
        (for/vector ((f free-fields))
          (define actnow (action player f))
          (define board1 (board-take-field board0 player f))
          (vector actnow (generate-tree board1 opponent player)))))

  ;; -- start here --
  (generate-tree the-empty-board player1 player2))
   
;;; 9! = 362880
;;; :-(
(let ((gt (generate-ttt-tree XP OP)))
  '())
```

# 11 Power to the Lazy

- Lazy Racket language: `#lang lazy`
- library `racket/promise`: `delay`, `force`

# 12 Artificial Intelligence

lazy
```racket
(game (board player (delay ...)))
```

force
- `force` `game-moves`, or
- redefine `game-moves`
```racket
(struct game (board player delayed-moves))
(lambda (g) (force (game-delayed-moves g)))
```

# 13 The World is Not Enough

distributed game
- server
- client

`2htdp/universe`

module
```racket
#lang racket

require
provide

struct-out
```

client
```racket
(define ClientState0  "no guess available")

;;; launch-guess-client
(big-bang ClientState0
          (on-draw draw-guess)
          (on-key handle-keys)
          (name n)
          (register host)
          (on-receive handle-msg))
```

server
```racket
(struct interval (small big) #:transparent)

;;; launch-guess-server
(universe #f
          (state #t)
          (on-new connect)
          (on-msg handle-msg))
```

run
```racket
(launch-many-worlds (launch-guess-client "Adam" LOCALHOST)
                    (launch-guess-server))
```

# 14 Hungry Henry

state machine

shared
```racket
;;; Client To Server Message
(list GOTO PositiveNumber PositiveNumber)        ; the coordinates of player's latest waypoint

;;; Server to Client Message
Number ∈ [0,1]                                   ; a Time message 
ID                                               ; an Ackn message 
(list SERIALIZE [Listof Feaster] [Listof Food])  ; a State message
(list SCORE [Listof (list Id Natural)])          ; a Score message 

(struct player (id body waypoints) #:prefab)
(struct body (size loc) #:prefab #:mutable)
```

client
```racket
;;; meal
(struct app (id img countdown) #:transparent)    ; 开胃菜
(struct entree (id players food) #:transparent)  ; 主菜

(define INITIAL (app #f LOADING ZERO%))
(big-bang INITIAL
          (to-draw render-the-meal)
          (on-mouse set-waypoint)
          (on-receive handle-server-messages)
          (register server)
          (name label))
```

server
```racket
(struct join (clients [time #:mutable]) #:transparent)
(struct play (players food spectators) #:transparent #:mutable)

(universe JOIN0
          (on-new connect)
          (on-msg handle-goto-message)
          (on-tick tick-tock TICK)
          (on-disconnect disconnect))
```

# Good Bye: Close Paren

- run Racket run
hellow-world.rkt
```racket
#lang racket/base
"Hello, world."
```

```shell
$ racket hellow-world.rkt

$ raco exe -l hello-world.rkt
$ ./hello-world
```

- Racket is a Programming Langauge

- Racket is a Programming-Langauge Programming Langauge
```racket
define-syntax-rule
```

language provide 3 common forms:
```racket
#%module-begin ; wrap entire module
#%app          ; wrap each function application
#%dataum       ; wrap each data
```