# How to Design Programs - Teachpacks

# 1 HtDP Teachpacks
## 1.1 Manipulating Images: "image.rkt"
### 1.1.1 Images
### 1.1.2 Modes and Colors
### 1.1.3 Creating Basic Shapes
### 1.1.4 Basic Image Properties
### 1.1.5 Composing Images
### 1.1.6 Manipulating Images
### 1.1.7 Scenes
### 1.1.8 Miscellaneous Image Manipulation and Creation

## 1.2 Simulations and Animations: "world.rkt"
### 1.2.1 Simple Simulations
### 1.2.2 Interactions
### 1.2.3 A First Example
### 1.2.3.1 Understanding a Door
### 1.2.3.2 Simulations of the World
### 1.2.3.3 Simulating a Door: Data
### 1.2.3.4 Simulating a Door: Functions

## 1.3 Converting Temperatures: "convert.rkt"

## 1.4 Guessing Numbers: "guess.rkt"

## 1.5 MasterMinding: "master.rkt"

## 1.6 Playing MasterMind: "master-play.rkt"

## 1.7 Simple Drawing: "draw.rkt"
### 1.7.1 Drawing on a Canvas
### 1.7.2 Interactions with Canvas

## 1.8 Hangman: "hangman.rkt"

## 1.9 Playing Hangman: "hangman-play.rkt"

## 1.10 Managing Control Arrows: "arrow.rkt"

## 1.11 Manipulating Simple HTML Documents: "docs.rkt"

## 1.12 Working with Files and Directories: "dir.rkt"

## 1.13 Graphing Functions: "graphing.rkt"

## 1.14 Simple Graphical User Interfaces: "gui.rkt"

## 1.15 An Arrow GUI: "arrow-gui.rkt"

## 1.16 Controlling an Elevator: "elevator.rkt"

## 1.17 Lookup GUI: "lkup-gui.rkt"

## 1.18 Guess GUI: "guess-gui.rkt"

## 1.19 Queens: "show-queen.rkt"

## 1.20 Matrix Functions: "matrix.rkt"
### 1.20.1 Matrix Snip

# 2 HtDP/2e Teachpacks
## 2.1 Batch Input/Output: "batch-io.rkt"
### 2.1.1 IO Functions
### 2.1.2 Web Functions
### 2.1.3 Testing

## 2.2 Image Guide
### 2.2.1 Overlaying, Above, and Beside: A House
### 2.2.2 Rotating and Overlaying: A Rotary Phone Dial
### 2.2.3 Alpha Blending
### 2.2.4 Recursive Image Functions
### 2.2.5 Rotating and Image Centers
### 2.2.6 Image Interoperability
### 2.2.7 The Nitty Gritty of Pixels, Pens, and Lines
### 2.2.8 The Nitty Gritty of Alpha Blending

## 2.3 Images: "image.rkt"
### 2.3.1 Basic Images
### 2.3.2 Polygons
### 2.3.3 Overlaying Images
### 2.3.4 Placing Images & Scenes
### 2.3.5 Rotating, Scaling, Flipping, Cropping, and Framing Images
### 2.3.6 Bitmaps
### 2.3.7 Image Properties
### 2.3.8 Image Predicates
### 2.3.9 Equality Testing of Images
### 2.3.10 Pinholes
### 2.3.11 Exporting Images to Disk

## 2.4 Worlds and the Universe: "universe.rkt"
### 2.4.1 Background
### 2.4.2 Simple Simulations
```racket
(animate create-image) → natural-number/c
;  create-image : (-> natural-number/c scene?)

(run-simulation create-image) → natural-number/c
;  create-image : (-> natural-number/c scene?)

(run-movie r m) → [Listof image?]
;  r : (and/c real? positive?)
;  m : [Listof image?]
```
### 2.4.3 Interactions
```racket
(big-bang state-expr clause ...)
; clause	 	=	 	(on-tick tick-expr)
;  	 	|	 	(on-tick tick-expr rate-expr)
;  	 	|	 	(on-tick tick-expr rate-expr limit-expr)
;  	 	|	 	(on-key key-expr)
;  	 	|	 	(on-pad pad-expr)
;  	 	|	 	(on-release release-expr)
;  	 	|	 	(on-mouse mouse-expr)
;  	 	|	 	(to-draw draw-expr)
;  	 	|	 	(to-draw draw-expr width-expr height-expr)
;  	 	|	 	(stop-when stop-expr)
;  	 	|	 	(stop-when stop-expr last-scene-expr)
;  	 	|	 	(check-with world?-expr)
;  	 	|	 	(record? r-expr)
;  	 	|	 	(close-on-stop cos-expr)
;  	 	|	 	(display-mode d-expr)
;  	 	|	 	(state expr)
;  	 	|	 	(on-receive rec-expr)                       ; receive message from universe
;  	 	|	 	(register IP-expr)                          ; register to universe
;  	 	|	 	(port Port-expr)
;  	 	|	 	(name name-expr)
```

### 2.4.4 A First Sample World
### 2.4.4.1 Understanding a Door
### 2.4.4.2 Hints on Designing Worlds
### 2.4.5 The World is not Enough
### 2.4.5.1 Messages
In terms of data, a message is just an S-expression.
an S-expression is one of: a string, a symbol, a number, a boolean, a char, or a list of S-expressions, a prefab struct of S-expressions, or a byte string.

### 2.4.5.2 Sending Messages
```racket
(make-package w m) → package?
;  w : any/c
;  m : sexp?
```
### 2.4.5.3 Connecting with the Universe
```racket
(register ip-expr)
;  	ip-expr	 	:	 	string?
(port port-expr)
;  	port-expr	 	:	 	natural-number/c
```
### 2.4.5.4 Receiving Messages
```racket
(on-receive receive-expr)
;  	receive-expr	 	:	 	(-> WorldState sexp? HandlerResult)
```
### 2.4.6 The Universe Server
### 2.4.6.1 Worlds and Messages
```racket
(make-bundle state mails low-to-remove) → bundle?
;   state : any/c
;   mails : (listof mail?)
;   low-to-remove : (listof iworld?)

(make-mail to content) → mail?
;   to : iworld?
;   content : sexp?
```
### 2.4.6.2 Universe Descriptions
```racket
(universe state-expr clause ...)
; clause	 	=	 	(on-new new-expr)                    ; handle new connection
;  	 	|	 	(on-msg msg-expr)                          ; handle messages from client
;  	 	|	 	(on-tick tick-expr)
;  	 	|	 	(on-tick tick-expr rate-expr)
;  	 	|	 	(on-tick tick-expr rate-expr limit-expr)
;  	 	|	 	(on-disconnect dis-expr)
;  	 	|	 	(state expr)
;  	 	|	 	(to-string render-expr)
;  	 	|	 	(port port-expr)
;  	 	|	 	(check-with universe?-expr)
```

### 2.4.6.3 Exploring a Universe
```racket
(launch-many-worlds expression ...)

(launch-many-worlds/proc	 	thunk-that-runs-a-world	 	 	 	 
 	 	...)	 	→	 	any	 	...
;   thunk-that-runs-a-world : (-> any/c)
```

### 2.4.7 A First Sample Universe
### 2.4.7.1 Two Ball Tossing Worlds
### 2.4.7.2 Hints on Designing Universes
### 2.4.7.3 Designing the Ball Universe
### 2.4.7.4 Designing the Ball Server
### 2.4.7.5 Designing the Ball World

## 2.5 Web IO: "web-io.rkt"

## 2.6 iTunes: "itunes.rkt"
### 2.6.1 Data Definitions
### 2.6.2 Exported Functions

## 2.7 Abstraction: "abstraction.rkt"
### 2.7.1 Loops and Comprehensions
### 2.7.2 Pattern Matching
### 2.7.3 Algebraic Data Types

## 2.8 Planet Cute Images
### 2.8.1 Characters
### 2.8.2 Blocks
### 2.8.3 Items
### 2.8.4 Ramps
### 2.8.5 Buildings
### 2.8.6 Shadows

## 2.9 Porting World Programs to Universe
### 2.9.1 The World is Not Enough
### 2.9.2 Porting World Programs
### 2.9.3 Porting Image Programs