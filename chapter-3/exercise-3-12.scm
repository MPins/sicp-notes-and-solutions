;guile 3.0.9
;Exercise 3.12
(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))

(format #t "z = ~a\n" z)

(format #t "cdr(x) = ~a\n" (cdr x))
(format #t "car(z) = ~a\n" (car z))
(format #t "cdr(z) = ~a\n" (cdr z))
(format #t "car(cdr(z)) = ~a\n" (car(cdr z)))
(format #t "cdr(cdr(z)) = ~a\n" (cdr(cdr z)))
(format #t "cdr(cdr(z)) = y? ~a\n" (eq? (cdr(cdr z)) y))
(format #t "x = z? ~a\n" (eq? z x))


(define w (append! x y))

(format #t "w = ~a\n" w)

(format #t "cdr(x) = ~a\n" (cdr x))
(format #t "car(w) = ~a\n" (car w))
(format #t "cdr(w) = ~a\n" (cdr w))
(format #t "car(cdr(w)) = ~a\n" (car(cdr w)))
(format #t "cdr(cdr(w)) = ~a\n" (cdr(cdr w)))
(format #t "cdr(cdr(w)) = y? ~a\n" (eq? (cdr(cdr w)) w))
(format #t "x = w? ~a\n" (eq? w x))
