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

