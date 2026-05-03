;guile 3.0.9
;Exercise 3.2: In software-testing applications, it is useful to be able to count
;the number of times a given procedure is called during the course of a computation.
;Write a procedure make-monitored that takes as input a procedure, f,that itself takes
;one input. The result returned by make-monitored is a third procedure, say mf, that
;keeps track of the number of times it has been called by maintaining an internal counter.
;If the input to mf is the special symbol how-many-calls?, then mf returns the value of
;the counter. If the input is the special symbol reset-count, then mf resets the counter
;to zero. For any other input, mf returns the result of calling f on that input and
;increments the counter. For instance, we could make a monitored version of the sqrt procedure:
(define (make-monitored function)
    (define total 0)
    (define (monitored-call arg)
        (set! total (+ total 1))
        (function arg))
    (define (how-many-calls?) total)
    (define (reset-count) (set! total 0))
    (define (dispatch m)
        (cond ((eq? m 'reset-count) (reset-count))
        ((eq? m 'how-many-calls?) (how-many-calls?))
        (else (monitored-call m))))
    dispatch)

(define s (make-monitored sqrt))

(format #t "s => monitored sqr, s(100) = ~a\n" (s 100))
(format #t "number of s calls ~a\n" (s 'how-many-calls?))
(s 'reset-count)
(format #t "number of s calls after the reset ~a\n" (s 'how-many-calls?))
