;test 1
(amb 1 2 3)

;test 2 
(define x (amb 1 2 3))
x

;test 3
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items)
       (an-element-of (cdr items))))

(an-element-of '(a b c))

;test4
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items)
       (an-element-of (cdr items))))

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (prime-sum-pair list1 list2)
    (let ((a (an-element-of list1))
          (b (an-element-of list2)))
         (require (prime? (+ a b)))
            (list a b)))       

(prime-sum-pair '(1 3 5 8) '(20 35 110))