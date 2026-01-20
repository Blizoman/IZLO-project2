(set-logic NIA)

(set-option :produce-models true)
(set-option :incremental true)

; Deklarace promennych pro vstupy
; ===============================

; Parametry
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () Int)
(declare-fun D () Int)
(declare-fun E () Int)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; START OF SOLUTION ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; XLOGIN: xblizna00

; Zde doplnte vase reseni
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)

(declare-fun DD () Int)  
(declare-fun EE () Int) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(assert (and (> D 0) (> E 0)))

(assert 
    (= x (- (* A B) (* C 5)))
)

(assert 
    (= y 
        (ite (< (+ x E) (+ D D))
                  (+ x (* 3 B))
                  (* x C 2))
    )
)

(assert 
    (= z 
        (ite (<= (- y 5) C)
            (- (* x A) (* y B))
            (ite (> (+ x 2) D)
                (* (+ x A) (+ y B))
                (+ (* x B) (* y A)))
        )
    )
)

(assert (> z (+ D E))) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-fun controller ((DD Int) (EE Int)) Bool 
    (and 
        (and (> DD 0) (> EE 0))
        (> (ite (<= (- (ite (< (+ (- (* A B) (* C 5)) EE) (+ DD DD))
                  (+ (- (* A B) (* C 5)) (* 3 B))
                  (* (- (* A B) (* C 5)) C 2)) 5) C)
            (- (* (- (* A B) (* C 5)) A) (* (ite (< (+ (- (* A B) (* C 5)) EE) (+ DD DD))
                  (+ (- (* A B) (* C 5)) (* 3 B))
                  (* (- (* A B) (* C 5)) C 2)) B))
            (ite (> (+ (- (* A B) (* C 5)) 2) D)
                (* (+ (- (* A B) (* C 5)) A) (+ (ite (< (+ (- (* A B) (* C 5)) EE) (+ DD DD))
                  (+ (- (* A B) (* C 5)) (* 3 B))
                  (* (- (* A B) (* C 5)) C 2)) B))
                (+ (* (- (* A B) (* C 5)) B) (* (ite (< (+ (- (* A B) (* C 5)) EE) (+ DD DD))
                  (+ (- (* A B) (* C 5)) (* 3 B))
                  (* (- (* A B) (* C 5)) C 2)) A)))
        ) (+ DD EE))
    )   
)
;doplnal som do povodnej "deklaracie" postupne tak aby som sa zbavil vsetkych neznamych teda ze:
; (D>0 && E>0) && (z > D+E), za 'z': if(y - 5 <= C){z = x*A - y*b}, elif(x+2 > D){z = (x + A) * (y + B)}...
; a zase to iste nezname su 'y' tak dosadim za vsetky 'y' vzorec a nakoniec 'x'...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(assert 
    (not
        (exists((DD Int) (EE Int))
            (and
                (controller DD EE)
                (> (+ D E) (+ DD EE))
            )
        )
    )
)
;; V predikatovej: Neexistuje a,b: ((a && b vyhovuje podmienkam pre D && E) && (a+b < D+E))
;; 'controller' vracia true ak teda a,b vyhovujuje podmienkam, za kontrolerom 
;; uz len podmienka ze taka dvojica neexistuje, to zabezpeci unsat po najdeni ineho vysledku

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; END OF SOLUTION ;;;;;;;;;; ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Testovaci vstupy

; ================

(echo "Test 1 - vstup A=1, B=1, C=3")
(echo "a) Ocekavany vystup je sat a D+E se rovna 17")
(check-sat-assuming (
  (= A 1) (= B 1) (= C 3)
))
(get-value (D E (+ D E)))

(echo "b) Neexistuje jine reseni nez 17, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 1) (= B 1) (= C 3) (distinct (+ D E) 17)
))

(echo "")
(echo "")

(echo "Test 2 - vstup A=5, B=2, C=5")
(echo "a) Ocekavany vystup je sat a D+E se rovna 18")
(check-sat-assuming (
  (= A 5) (= B 2) (= C 5)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 18, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 5) (= B 2) (= C 5) (distinct (+ D E) 18)
))

(echo "")
(echo "")

(echo "Test 3 - vstup A=100, B=15, C=1")
(echo "a) Ocekavany vystup je sat a D+E se rovna 2")
(check-sat-assuming (
  (= A 100) (= B 15) (= C 1)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 2, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 100) (= B 15) (= C 1) (distinct (+ D E) 2)
))

(echo "")
(echo "")

(echo "Test 4 - vstup A=5, B=5, C=3")
(echo "a) Ocekavany vystup je sat a D+E se rovna 2")
(check-sat-assuming (
  (= A 5) (= B 5) (= C 3)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 2, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 5) (= B 5) (= C 3) (distinct (+ D E) 2)
))

(echo "")
(echo "")

(echo "Test 5 - vstup A=1, B=1, C=1")
(echo "a) Ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 1) (= B 1) (= C 1)
))

(echo "")
(echo "")

(echo "Test 6 - vstup A=4, B=5, C=3")
(echo "a) Ocekavany vystup je sat a D+E se rovna 2")
(check-sat-assuming (
  (= A 4) (= B 5) (= C 3)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 2, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 4) (= B 5) (= C 3) (distinct (+ D E) 2)
))

(echo "")
(echo "")

(echo "Test 7 - vstup A=0, B=0, C=0")
(echo "a) Ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 0) (= B 0) (= C 0)
))

(echo "")
(echo "")

(echo "Test 8 - vstup A=100, B=-50, C=-75")
(echo "a) Ocekavany vystup je sat a D+E se rovna 4628")
(check-sat-assuming (
  (= A 100) (= B -50) (= C -75)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 4628, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 100) (= B -50) (= C -75) (distinct (+ D E) 4628)
))

(echo "")
(echo "")

(echo "Test 9 - vstup A=3, B=2, C=2")
(echo "a) Ocekavany vystup je sat a D+E se rovna 7")
(check-sat-assuming (
  (= A 3) (= B 2) (= C 2)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 7, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 3) (= B 2) (= C 2) (distinct (+ D E) 7)
))

(echo "")
(echo "")

(echo "Test 10 - vstup A=-100, B=-15, C=-90")
(echo "a) Ocekavany vystup je sat a D+E se rovna 977")
(check-sat-assuming (
  (= A -100) (= B -15) (= C -90)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 977, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A -100) (= B -15) (= C -90) (distinct (+ D E) 977)
))

