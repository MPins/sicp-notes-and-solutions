;Exercise 4.1: Notice that we cannot tell whether the metacircular
;evaluator evaluates operands from left to right or from right to left.
;Its evaluation order is inherited from the underlying Lisp: If the
;arguments to cons in list-of-values are evaluated from left to right,
;then list-of-values will evaluate operands from left to right; and if
;the arguments to cons are evaluated from right to left, then list-of-values
;will evaluate operands from right to left.
;Write a version of list-of-values that evaluates operands from left to right
;regardless of the order of evaluation in the underlying Lisp. Also write a
;version of list-of-values that evaluates operands from right to left.

;The original version of list-of-values 
(define (list-of-values exps env)
    (if (no-operands? exps)
        '()
        (cons (eval (first-operand exps) env)
              (list-of-values (rest-operands exps) env))))

;A version of list-of-values that evaluates operands from left to right
(define (list-of-values-left-to-right exps env)
    (if (no-operands? exps)
        '()
        (let ((first-val (eval (first-operand exps) env)))
          (cons first-val
                (list-of-values-left-to-right (rest-operands exps) env)))))

;A version of list-of-values that evaluates operands from right to left
(define (list-of-values-right-to-left exps env)
    (if (no-operands? exps)
        '()
        (let ((rest-vals (list-of-values-right-to-left (rest-operands exps) env)))
          (cons (eval (first-operand exps) env) rest-vals))))
