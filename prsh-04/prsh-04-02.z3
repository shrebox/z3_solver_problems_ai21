; Authors: 
; Aleena Siji (7010829)
; Shreyash Arya (7015279)
; Sili Vettiyara Sunil (7009731)

(declare-fun p (Int Int) Bool)
(declare-fun q (Int Int) Bool)
(declare-fun r (Int Int) Bool)

(assert
    (=>
        (and
            (forall
                ((x Int)) 
                (exists
                    ((y Int))
                    (p x y)
                )   
            )
            (forall
                ((x Int)) 
                (exists
                    ((y Int))
                    (= (q x y) true)
                )
                
            )
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
        (forall
            ((x Int)) 
            (exists
                ((y Int))
                (= (r x y) true)
            )   
        )
    )
)

(check-sat)

