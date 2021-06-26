; Authors: 
; Aleena Siji (7010829)
; Shreyash Arya (7015279)
; Sili Vettiyara Sunil (7009731)
; The code is executed successfully on https://rise4fun.com/Z3

(declare-const x Int)
(declare-const y Int)
(declare-const z Int)

(declare-fun p (Int Int) Bool)
(declare-fun q (Int Int) Bool)
(declare-fun r (Int Int) Bool)

; Condition 1:
(assert
    (forall
        ((x Int))
        (exists
            ((y Int))
            (p x y)
        )
    )
)

; Condition 2:
(assert
    (forall
        ((x Int))
        (exists
            ((y Int))
            (q x y)
        )
    )
)

; Condition 3:
(assert
    (forall
        ((x Int) (y Int))
        (=>
            (or
                (p x y)
                (q x y)
            )
            (forall
                ((z Int))
                (=>
                    (or
                        (p y z)
                        (q y z)
                    )
                    (r x z)
                )
            )
        )
    )
)

; To prove (A --> B), we can show that (not (A --> B)) is a fallacy
; (not (A --> B)) is same as (A AND (not B))
; Here A corresponds to the three conditions given above and B is the conclusion to be proven
; Below (not B): 
(assert
    (not
        (forall
            ((x Int))
            (exists
                ((y Int))
                (r x y)
            )
        )
    )
)

; So, by the proof by contradiction, 
; the result should be unsatisfiable as the negation of conclusion is not true
(check-sat)

