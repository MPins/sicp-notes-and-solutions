; Exercise 3.55: Define a procedure partial-sums that takes as argument a stream S
; and returns the stream whose elements are S0, S0 +S1, S0 +S1 +S2 , . . ..
; For example, (partial-sums integers) should be the stream 1, 3, 6, 10, 15, . . ..
(include "../journal/stream-v2.scm")
(include "../journal/add-streams.scm")
(define ones (cons-stream 1 ones))
(define integers
    (cons-stream 1 (add-streams ones integers)))

(define (partial-sums s)    
    (cons-stream
        (stream-car s)
        (add-streams (partial-sums s) (stream-cdr s))))

(display (stream-ref (partial-sums integers) 0)) ;1
(newline)
(display (stream-ref (partial-sums integers) 1)) ;3
(newline)
(display (stream-ref (partial-sums integers) 2)) ;6
(newline)
(display (stream-ref (partial-sums integers) 3)) ;10
(newline)
(display (stream-ref (partial-sums integers) 4)) ;15
