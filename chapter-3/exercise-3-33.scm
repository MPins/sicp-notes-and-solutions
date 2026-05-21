;Exercise 3.33: Using primitive multiplier, adder, and constant
;constraints, define a procedure averager that takes three connectors
; a, b, and c as inputs and establishes the constraint that the value
;of c is the average of the values of a and b.
(load "../journal/propagation-of-constrains.scm")

(define (averager a b c)
    (let ((z (make-connector))
          (t (make-connector)))
          (adder a b z)
          (multiplier c t z)
          (constant 2 t)
          'ok))

(define A (make-connector))
(define B (make-connector))
(define C (make-connector))

(averager A B C)
(probe "A" A)
(probe "B" B)
(probe "C" C)

(set-value! A 10 'user)
(set-value! B 20 'user)
(display "\n")
(forget-value! A 'user)
(display "\n")
(set-value! A 20 'user)
(display "\n")
(forget-value! B 'user)
(display "\n")
(set-value! B 30 'user)
(display "\n")