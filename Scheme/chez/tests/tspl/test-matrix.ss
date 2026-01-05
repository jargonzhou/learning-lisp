(import (tspl matrix)
        (io simple) 
        (rnrs))

(prs
  
  ; scalar times scalar
  (mul 3 4)
  
  ; scalar times vector
  (mul 1/2 '#(#(1 2 3)))
  
  ; scalar times matrix
  (mul -2 '#(#(3 -2 1)
             #(-3 0 -5)
             #(7 -1 -1)))

  ; vector times matrix
  (mul '#(#(1 2 3))
       '#(#(2 3)
          #(3 4)
          #(4 5)))

  ; matrix times vector
  (mul '#(#(2 3 4)
          #(3 4 5))
       '#(#(1) #(2) #(3)))

  ; matrix times matrix
  (mul '#(#(1 2 3)
          #(4 5 6))
       '#(#(1 2 3 4)
          #(2 3 4 5)
          #(3 4 5 6))))