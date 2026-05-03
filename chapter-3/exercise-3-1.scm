;guile 3.0.9
;Exercise 3.1: An accumulator is a procedure that is called repeatedly with a single
;numeric argument and accumulates its arguments into a sum. Each time it is called, it
;returns the currently accumulated sum. Write a procedure make-accumulator that generates
;accumulators, each maintaining an independent sum. The input to make-accumulator
;should specify the initial value of the sum.
(define (make-accumulator total)
    (define (acumulator amount)
        (begin
            (set! total (+ total amount))
            total))
    acumulator)

(define A (make-accumulator 5))
(define B (make-accumulator 100))

(format #t "A = ~a and B = ~a\n" (A 10) (B 10))
(format #t "A = ~a and B = ~a\n" (A 10) (B 10))