; Authors: 
; Aleena Siji (7010829)
; Shreyash Arya (7015279)
; Sili Vettiyara Sunil (7009731)

(declare-datatypes () ((Block A B C D E)))
(declare-fun On (Block Block) Bool)
(declare-fun Below (Block Block) Bool)

; axiom
; ∀x ∀z [Below(x , z ) ⇔ (On(z , x )∨ ∃y [On(z , y)∧Below(x , y)])] 
(assert
    (forall
        ((x Block) (z Block))
        (and    
            (=> 
                (Below x z)
                (or
                    (On z x)
                    (exists
                        ((y Block))
                        (and
                            (On z y)
                            (Below x y)
                        )
                    )
                )
            )
            (=> 
                (or
                    (On z x)
                    (exists
                        ((y Block))
                        (and
                            (On z y)
                            (Below x y)
                        )
                    )
                )
                (Below x z)
            )
        )
    )
)

; current situation
(assert (= (On A B) true))
(assert (= (On C D) true))
(assert (= (On D E) true))
(assert (= (On B A) false))
(assert (= (On D C) false))
(assert (= (On E D) false))
(assert (= (On B C) false))
(assert (= (On C B) false))
(assert (= (On C E) false))
(assert (= (On E C) false))
(assert (= (On A E) false))
(assert (= (On E A) false))
(assert (= (On B E) false))
(assert (= (On E B) false))
(assert (= (On B D) false))
(assert (= (On D B) false))
(assert (= (On A D) false))
(assert (= (On D A) false))
(assert (= (On A C) false))
(assert (= (On C A) false))

; to show
(assert (Below E C))

(check-sat)
