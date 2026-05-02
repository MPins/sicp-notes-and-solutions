;guile 3.0.9
;Exercise 2.75: Implement the constructor make-from-mag-angle in message-passing style.
;; tabela global
(define (make-from-real-imag x y)
    (define (dispatch op)
        (cond   ((eq? op 'real-part) x)
                ((eq? op 'imag-part) y)
                ((eq? op 'magnitude) (sqrt (+ (square x) (square y))))
                ((eq? op 'angle) (atan y x))
                (else (error "Unknown op: MAKE-FROM-REAL-IMAG" op))))
    dispatch)

(define (make-from-mag-angle x y)
    (define (dispatch op)
        (cond   ((eq? op 'magnitude) x)
                ((eq? op 'angle) y)
                ((eq? op 'real-part) (* x (cos y)))
                ((eq? op 'imag-part) (* x (sin y)))
                (else (error "Unknown op: MAKE-FROM-MAG-ANGLE" op))))
    dispatch)

(define (square x) (* x x))

(define (apply-generic op arg) (arg op))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))
                   
(define z1 (make-from-real-imag 3 4))

(format #t "real part of z1 = ~a\n" (real-part z1))
(format #t "imag part of z1 = ~a\n" (imag-part z1))
(format #t "magnitude of z1 = ~a\n" (magnitude z1))
(format #t "angle of z1 = ~a\n" (angle z1))

(display "\n\n")

(define z2 (make-from-mag-angle 3 4))

(format #t "real part of z2 = ~a\n" (real-part z2))
(format #t "imag part of z2 = ~a\n" (imag-part z2))
(format #t "magnitude of z2 = ~a\n" (magnitude z2))
(format #t "angle of z2 = ~a\n" (angle z2))
