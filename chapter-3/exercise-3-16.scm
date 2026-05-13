;guile 3.0.9
;Exercise 3.16
(define (count-pairs x)
    (if (not (pair? x))
        0
        (+ (count-pairs (car x)) (count-pairs (cdr x)) 1)))

(define z0 (list 'a 'b 'c))
(format #t "(count-pairs z0) = ~a" (count-pairs z0))
(display "\n")

(define x (cons 'a 'b))
(define z1 (list x x))
(format #t "(count-pairs z1) = ~a" (count-pairs z1))
(display "\n")

(define y (cons x x))
(define z2 (cons y y))
(format #t "(count-pairs z2) = ~a" (count-pairs z2))
(display "\n")

(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)

(make-cycle z0)
(format #t "(count-pairs z0) = ~a" (count-pairs z0))
(display "\n")

