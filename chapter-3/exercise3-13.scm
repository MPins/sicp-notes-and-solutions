;guile 3.0.9
;Exercise 3.13
(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)

(define z (make-cycle (list 'a 'b 'c)))

;The line below causes an infinite loop.
(define w (last-pair z))
