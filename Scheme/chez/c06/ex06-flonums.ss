(import (io simple))

(comments "flonum?")
(prs
  (flonum? 0) 
  (flonum? 3/4) 
  (flonum? 3.5) 
  (flonum? .02) 
  (flonum? 1e10) 
  (flonum? 3.0+0.0i) 
)

(comments "fl=?, fl<?, fl>?, fl<=?, fl>=?")
(prs
  (fl=? 0.0 0.0) 
  (fl<? -1.0 0.0 1.0) 
  (fl>? -1.0 0.0 1.0) 
  (fl<=? 0.0 3.0 3.0) 
  (fl>=? 4.0 3.0 3.0) 
  (fl<? 7.0 +inf.0) 
  (fl=? +nan.0 0.0) 
  (fl=? +nan.0 +nan.0) 
  (fl<? +nan.0 +nan.0) 
  (fl<=? +nan.0 +inf.0) 
  (fl>=? +nan.0 +inf.0) 
)

(comments "flzero?, flpositive?, flnegative?")
(prs
  (flzero? 0.0) 
  (flzero? 1.0) 

  (flpositive? 128.0) 
  (flpositive? 0.0) 
  (flpositive? -1.0) 

  (flnegative? -65.0) 
  (flnegative? 0.0) 
  (flnegative? 1.0) 

  (flzero? -0.0) 
  (flnegative? -0.0) 

  (flnegative? +nan.0) 
  (flzero? +nan.0) 
  (flpositive? +nan.0) 

  (flnegative? +inf.0) 
  (flnegative? -inf.0) 
)

(comments "flinteger?")
(prs
  (flinteger? 0.0) 
  (flinteger? -17.0) 
  (flinteger? +nan.0) 
  (flinteger? +inf.0) 
)

(comments "flfinite?, flinfinite?, flnan?")
(prs
  (flfinite? 3.1415) 
  (flinfinite? 3.1415) 
  (flnan? 3.1415) 

  (flfinite? +inf.0) 
  (flinfinite? -inf.0) 
  (flnan? -inf.0) 

  (flfinite? +nan.0) 
  (flinfinite? +nan.0) 
  (flnan? +nan.0) 
)

(comments "fleven?, flodd?")
(prs
  (fleven? 0.0) 
  (fleven? 1.0) 
  (fleven? -1.0) 
  (fleven? -10.0) 

  (flodd? 0.0) 
  (flodd? 1.0) 
  (flodd? -1.0) 
  (flodd? -10.0) 
)

(comments "flmin, flmax")
(prs
  (flmin 4.2 -7.5 2.0 0.0 -6.4) 

  (let ([ls '(7.1 3.5 5.0 2.6 2.6 8.0)])
    (apply flmin ls)) 

  (flmax 4.2 -7.5 2.0 0.0 -6.4) 

  (let ([ls '(7.1 3.5 5.0 2.6 2.6 8.0)])
    (apply flmax ls)) 
)

(comments "fl+, fl-, fl*, fl/")
(prs
  (fl+) 
  (fl+ 1.0 2.5) 
  (fl+ 3.0 4.25 5.0) 
  (apply fl+ '(1.0 2.0 3.0 4.0 5.0)) 

  (fl- 0.0) 
  (fl- 3.0) 
  (fl- 4.0 3.0) 
  (fl- 4.0 3.0 2.0 1.0) 

  (fl*) 
  (fl* 1.5 2.5) 
  (fl* 3.0 -4.0 5.0) 
  (apply fl* '(1.0 -2.0 3.0 -4.0 5.0)) 

  (fl/ -4.0) 
  (fl/ 8.0 -2.0) 
  (fl/ -9.0 2.0) 
  (fl/ 60.0 5.0 3.0 2.0) 
)

(comments "fldiv, flmod, fldiv-and-mod")
(prs
  (fldiv 17.0 3.0) 
  (flmod 17.0 3.0) 
  (fldiv -17.0 3.0) 
  (flmod -17.0 3.0) 
  (fldiv 17.0 -3.0) 
  (flmod 17.0 -3.0) 
  (fldiv -17.0 -3.0) 
  (flmod -17.0 -3.0) 

  (let-values ([(d m) (fldiv-and-mod 17.5 3.75)])
    (list d m))
)

(comments "fldiv0, flmod0, fldiv0-and-mod0")
(prs
  (fldiv0 17.0 3.0) 
  (flmod0 17.0 3.0) 
  (fldiv0 -17.0 3.0) 
  (flmod0 -17.0 3.0) 
  (fldiv0 17.0 -3.0) 
  (flmod0 17.0 -3.0) 
  (fldiv0 -17.0 -3.0) 
  (flmod0 -17.0 -3.0) 

  (let-values ([(d m) (fldiv0-and-mod0 17.5 3.75)])
    (list d m))
)

(comments "flround, fltruncate, flfloor, flceiling")
(prs
  (flround 17.3) 
  (flround -17.3) 
  (flround 2.5) 
  (flround 3.5) 

  (fltruncate 17.3) 
  (fltruncate -17.3) 

  (flfloor 17.3) 
  (flfloor -17.3) 

  (flceiling 17.3) 
  (flceiling -17.3) 
)

(comments "flnumerator, fldenominator")
(prs
  (flnumerator -9.0) 
  (fldenominator -9.0) 
  (flnumerator 0.0) 
  (fldenominator 0.0) 
  (flnumerator -inf.0) 
  (fldenominator -inf.0) 
)

(comments "flabs")
(prs
  (flabs 3.2) 
  (flabs -2e-20) 
)

(comments "flexp, fllog")
(prs
  (flexp 0.0) 
  (flexp 1.0) 

  (fllog 1.0) 
  (fllog (exp 1.0)) 
  (fl/ (fllog 100.0) (fllog 10.0)) 

  (fllog 100.0 10.0) 
  (fllog .125 2.0) 
)

(comments "flsqrt")
(prs
  (flsqrt 4.0) 
  (flsqrt 0.0) 
  (flsqrt -0.0) 
)

(comments "flexpt")
(prs
  (flexpt 3.0 2.0) 
  (flexpt 0.0 +inf.0) 
)

(comments "fixnum->flonum, real->flonum")
(prs
  (fixnum->flonum 0) 
  (fixnum->flonum 13) 

  (real->flonum -1/2) 
  (real->flonum 1s3) 
)

(exit)