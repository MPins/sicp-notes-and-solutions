;guile 3.0.9
;Exercise 2.4: Here is an alternative procedural representation of pairs.
(define (cons x y)
    (lambda (m) (m x y)))
(define (car z)
    (z (lambda (p q) p)))
;For this representation, verify that (car (cons x y)) yields x for any objects x and y.
; Try it with numbers
(define number (cons 3 4))
(format #t "car of (cons 3 4) = ~a\n" (car number))
; Try it with names
(define name (cons 'maria 'jose))
(format #t "car of (cons 'maria 'jose) = ~a\n" (car name))

;What is the corresponding definition of cdr?
(define (cdr z)
    (z (lambda (p q) q)))
; Try it with numbers
(format #t "cdr of (cons 3 4) = ~a\n" (cdr number))
; Try it with  names
(format #t "cdr of (cons 'maria 'jose) = ~a\n" (cdr name))