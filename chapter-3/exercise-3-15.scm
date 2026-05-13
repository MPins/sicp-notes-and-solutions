;guile 3.0.9
;Exercise 3.15
(define x (list 'a 'b))
(define z1 (cons x x))

(define z2 (cons (list 'a 'b) (list 'a 'b)))

(define (set-to-wow! x) (set-car! (car x) 'wow) x)

(format #t "z1 = ~a\n" z1)
(set-to-wow! z1)
(format #t "z1 = ~a\n" z1)
(display "\n")
(format #t "z2 = ~a\n" z2)
(set-to-wow! z2)
(format #t "z2 = ~a\n" z2)

