(include "../journal/stream-v2.scm")
(include "../journal/add-streams.scm")
;Exercise 3.53
(define s (cons-stream 1 (add-streams s s)))
(display (stream-ref s 0)) ;1
(newline)
(display (stream-ref s 1)) ;2
(newline)
(display (stream-ref s 2)) ;4
(newline)