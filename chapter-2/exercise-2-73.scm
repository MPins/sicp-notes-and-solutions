;Exercise 2.73: Section 2.3.2 described a program that performs symbolic differentiation.
;guile 3.0.9
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))

(define (=number? exp num) (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
    (cond   ((=number? a1 0) a2)
            ((=number? a2 0) a1)
            ((and (number? a1) (number? a2)) (+ a1 a2))
            (else (list '+ a1 a2))))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (make-product m1 m2)
    (cond   ((or (=number? m1 0) (=number? m2 0)) 0)
            ((=number? m1 1) m2)
            ((=number? m2 1) m1)
            ((and (number? m1) (number? m2)) (* m1 m2))
            (else (list '* m1 m2))))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (deriv exp var)
    (cond ((number? exp) 0)
        ((variable? exp)
            (if (same-variable? exp var) 1 0))
        ((sum? exp)
            (make-sum
                (deriv (addend exp) var)
                (deriv (augend exp) var)))
        ((product? exp)
            (make-sum
                (make-product
                    (multiplier exp)
                    (deriv (multiplicand exp) var))
                (make-product
                    (deriv (multiplier exp) var)
                    (multiplicand exp))))                    
    (else (error "unknown expression type: DERIV" exp))))

(format #t "dx (x + 3)  = ~a\n" (deriv '(+ x 3) 'x))
(format #t "dx (x * 3)  = ~a\n" (deriv '(* x 3) 'x))

;We can regard this program as performing a dispatch on the type of the expression
;to be differentiated. In this situation the “type tag” of the datum is the algebraic
;operator symbol (such as +) and the operation being performed is deriv. We can
;transform this program into data-directed style by rewriting the basic derivative
;procedure.

;guile 3.0.9
;; tabela global
(define operation-table '())

(define (put op type proc)
    (set! operation-table (cons (list op type proc) operation-table)))

(define (get op type)
    (define (lookup records)
        (cond   ((null? records) #f)
                ((and (eq? op (car (car records))) (equal? type (cadr (car records)))) (caddr (car records)))
                (else (lookup (cdr records)))))
    (lookup operation-table))

(define (=number? x y) (and (number? x) (= x y)))

(define (variable? x) (symbol? x))

(define (same-variable? x y) (and (symbol? x) (symbol? y) (eq? x y)))

(define (install-deriv-sum-package)
    ;; internal procedures
    (define (addend s) (car s))
    (define (augend s) (cadr s))
    (define (make-sum a1 a2)
        (cond   ((=number? a1 0) a2)
                ((=number? a2 0) a1)
                ((and (number? a1) (number? a2))
                (+ a1 a2))
                (else (list '+ a1 a2))))    
    ;; interface to the rest of the system
    (put 'make '+ make-sum)
    (put 'deriv '+
        (lambda (operands var)
            (make-sum   (deriv (addend operands) var)
                        (deriv (augend operands) var))))
    'done)

(define (install-deriv-product-package)
    ;; internal procedures
    (define (multiplier p) (car p))
    (define (multiplicand p) (cadr p))  
    (define (make-product m1 m2)
        (cond   ((or (=number? m1 0) (=number? m2 0)) 0)
                ((=number? m1 1) m2)
                ((=number? m2 1) m1)
                ((and (number? m1) (number? m2)) (* m1 m2))
                (else (list '* m1 m2))))  
    ;; interface to the rest of the system
    (put 'make '* make-product)
    (put 'deriv '*
        (lambda (operands var)
            ((get 'make '+)
                (make-product
                    (multiplier operands)
                    (deriv (multiplicand operands) var))
                (make-product
                    (deriv (multiplier operands) var)
                    (multiplicand operands)))))
    'done)

;c. Choose any additional differentiation rule that you like, such as the one for exponents,
;and install it in this data-directed system.

(define (install-deriv-exponentiation-package)
    ;; internal procedures
    (define (base p) (car p))
    (define (exponent p) (cadr p))  
    (define (make-exponentiation b e)
        (cond   ((=number? e 0) 1)
                ((=number? e 1) b)
                ((and (number? b) (number? e)) (expt b e))
                (else (list '** b e))))  

    ;; interface to the rest of the system
    (put 'make '** make-exponentiation)
    (put 'deriv '**
        (lambda (operands var)
            (let ((b (base operands)) (e (exponent operands)))
                ((get 'make '*)
                    ((get 'make '*) e (make-exponentiation b (- e 1)))
                    (deriv b var)))))

    'done)

(define (deriv exp var)
    (cond   ((number? exp) 0)
            ((variable? exp) (if (same-variable? exp var) 1 0))
            (else ((get 'deriv (operator exp)) (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
  
(install-deriv-sum-package)
(install-deriv-product-package)
(install-deriv-exponentiation-package)

(format #t "dx (x + 3)  = ~a\n" (deriv '(+ x 3) 'x))
(format #t "dx (x * 3)  = ~a\n" (deriv '(* x 3) 'x))
(format #t "dx (x * y)  = ~a\n" (deriv '(* x y) 'x))
(format #t "dx (x ** 3) = ~a\n" (deriv '(** x 3) 'x))


