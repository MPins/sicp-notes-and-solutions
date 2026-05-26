;Exercise 3.54: Define a procedure mul-streams, analogous to add-streams,
;that produces the elementwise product of its two input streams. Use this
;together with the stream of integers to complete the following definition
;of the stream whose nth element (counting from 0) is n + 1 factorial:
; (define factorials (cons-stream 1 (mul-streams ⟨??⟩ ⟨??⟩)))
(include "../journal/stream-v2.scm")
(include "../journal/add-streams.scm")
(define ones (cons-stream 1 ones))
(define integers
    (cons-stream 1 (add-streams ones integers)))
(define (mul-streams s1 s2) (stream-map * s1 s2))
(define factorials (cons-stream 1 (mul-streams integers factorials)))

(display (stream-ref factorials 1)) ;1
(newline)
(display (stream-ref factorials 2)) ;2
(newline)
(display (stream-ref factorials 3)) ;6
(newline)
(display (stream-ref factorials 4)) ;24
(newline)
(display (stream-ref factorials 5)) ;120    






