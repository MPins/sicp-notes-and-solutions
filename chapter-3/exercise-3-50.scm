;Exercise 3.50
(include "../journal/stream.scm")
(define (stream-map proc . argstreams)
    (if (stream-null? (car argstreams))
        the-empty-stream
    (cons-stream
        (apply proc (map stream-car argstreams))
        (apply stream-map
            (cons proc (map stream-cdr argstreams))))))

(define s1 (stream-enumerate-interval 1 10))
(define s2 (stream-enumerate-interval 11 20))
(define s3 (stream-enumerate-interval 21 30))
(display-stream (stream-map + s1 s2 s3))
