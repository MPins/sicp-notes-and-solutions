;guile 3.0.9
;Exercise 2.5: Show that we can represent pairs of nonnegative integers
;using only numbers and arithmetic operations if we represent the pair
;a and b as the integer that is the product 2^a * 3^b . Give the corresponding
;definitions of the procedures cons, car, and cdr.
(define (cons a b)
    (* (expt 2 a) (expt 3 b)))
(define (car z)
    (define (count-2 n count)
        (if (not (= (remainder n 2) 0))
            count
            (count-2 (/ n 2) (+ count 1))))
    (count-2 z 0))
(define (cdr z)
(define (count-3 n count)
    (if (not (= (remainder n 3) 0))
        count
        (count-3 (/ n 3) (+ count 1))))
    (count-3 z 0))

(define number (cons 3 4))
(format #t "car of (cons 3 4) = ~a\n" (car number))