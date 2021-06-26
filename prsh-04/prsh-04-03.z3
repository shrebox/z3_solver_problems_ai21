(set-option :produce-models true)

; new types for persons and meals
(declare-datatypes () ((Person eve adam mike paula)))
(declare-datatypes () ((Meal salad soup cheese steak pasta)))

; which meal can be ordered for which course
(declare-fun Appetizer (Meal) Bool)
(declare-fun Main (Meal) Bool)

(assert (forall ((x Meal)) (= (Appetizer x) (or (= x salad) (= x soup) (= x cheese)))))
(assert (forall ((x Meal)) (= (Main x) (or (= x salad) (= x cheese) (= x steak) (= x pasta)))))

; which person orders which meal
(declare-fun Orders (Person Meal) Bool)


;;;;;;;;;;;;; ----START MODEL----   

;; TODO: Implement the statements 1 to 6

; 1 --> forall_x exits_y exists_z ((Orders x y) /\ (Orders x z)  /\ app_y /\ main_z)
(assert
    (forall
        ((x Person))
        (exists
            ((y Meal) (z Meal))
            (and
                (distinct y z) 
                (Orders x y)
                (Orders x z)
                (Appetizer y)
                (Main z)
                (forall
                    ((k Meal))
                    (=>
                        (and
                            (distinct y k)
                            (distinct z k)
                        )
                        (not (Orders x k))
                    )
                )
            )
        )
    )
)

; 2 --> forall_x exits_y (Orders y x)
(assert
    (forall
        ((x Meal))
        (exists
            ((y Person))
            (Orders y x)
        )
    )
)

; 3 --> TODO

(declare-fun twoOrMoreOrders (Meal) Bool) 
(assert
    (forall
        ((x Meal))
        (and
            (=>
                (exists 
                    ((y Person) (z Person))
                    (and
                        (distinct y z)
                        (Orders y x)
                        (Orders z x)
                    )
                )
                (=
                    (twoOrMoreOrders x)
                    true
                )
            )
            (=>
                (=
                    (twoOrMoreOrders x)
                    true
                )
                (exists 
                    ((y Person) (z Person))
                    (and
                        (distinct y z)
                        (Orders y x)
                        (Orders z x)
                    )
                )
            )
        )
    )
)

(assert
    (exists
        ((x Meal) (y Meal))
        (and
            (or
                (and (Appetizer x) (Main y))
                (and (Appetizer y) (Main x))
            )
            (and 
                (twoOrMoreOrders x)
                (twoOrMoreOrders y)
                (forall
                    ((k Meal))
                    (=>
                        (and
                            (distinct x k)
                            (distinct y k)
                        )
                        (not (twoOrMoreOrders k))
                    )
                )
            )
        )
    )
)

; 4 --> TODO
(assert
    (exists
        ((x Person))
        (or
            (and
                (Orders x salad)
                (Orders x cheese)
                (not (Orders x soup))
            )
            (and
                (Orders x salad)
                (Orders x soup)
                (not (Orders x cheese))
            )
            (and
                (Orders x soup)
                (Orders x cheese)
                (not (Orders x salad))
            )
        )
    )
)

; 5 --> forall_x (Orders x salad) => not(Orders x cheese)
(assert
    (forall
        ((x Person))
        (=>
            (Orders x salad)
            (not (Orders x cheese))
        )
    )
)

; 6
(assert
    (and
        (Orders eve cheese)
        (Orders adam steak)
        (Orders paula soup)
    )
)


;;;;;;;;;;;; ----END MODEL----


; check if satisfiable
(check-sat)

; print solution

(echo "Eve: Appetizer")
(get-value ((Orders eve salad) (Orders eve soup) (Orders eve cheese)))
(echo "Eve: Main Course")
(get-value ((Orders eve salad) (Orders eve cheese) (Orders eve steak) (Orders eve pasta)))
(echo "")

(echo "Adam: Appetizer")
(get-value ((Orders adam salad) (Orders adam soup) (Orders adam cheese)))
(echo "Adam: Main Course")
(get-value ((Orders adam salad) (Orders adam cheese) (Orders adam steak) (Orders adam pasta)))
(echo "")

(echo "Mike: Appetizer")
(get-value ((Orders mike salad) (Orders mike soup) (Orders mike cheese)))
(echo "Mike: Main Course")
(get-value ((Orders mike salad) (Orders mike cheese) (Orders mike steak) (Orders mike pasta)))
(echo "")

(echo "Paula: Appetizer")
(get-value ((Orders paula salad) (Orders paula soup) (Orders paula cheese)))
(echo "Paula: Main Course")
(get-value ((Orders paula salad) (Orders paula cheese) (Orders paula steak) (Orders paula pasta)))
(echo "")

