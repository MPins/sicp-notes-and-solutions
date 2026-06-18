;Exercise 4.2: Louis Reasoner plans to reorder the cond clauses in eval so that
;the clause for procedure applications appears before the clause for
;assignments. He argues that this will make the interpreter more efficient:
;Since programs usually contain more applications than assignments, definitions,
;and so on, his modified eval will usually check fewer clauses than the original
;eval before identifying the type of an expression.
;
;a. What is wrong with Louis’s plan? (Hint: What will Louis’s evaluator do with
;the expression (define x 3)?)
;Resp: It is not possible just change the order of the cond clauses in eval,
;because the clause for procedure applications will be checked before the clause for definitions.
;As a result, when the evaluator encounters the expression (define x 3), it will incorrectly
;identify it as a procedure application and attempt to apply the procedure 'define' to the arguments
;'x' and '3', which will lead to an error.

;b. Louis is upset that his plan didn’t work. He is willing to go to any lengths
;to make his evaluator recognize procedure applications before it checks for
;most other kinds of expressions. Help him by changing the syntax of the
;evaluated language so that procedure applications start with call. For example,
;instead of (factorial 3) we will now have to write (call factorial 3) and
;instead of (+ 1 2) we will have to write (call + 1 2).
;Resp: To change the syntax of the evaluated language so that procedure applications start with
;'call', we can modify the 'application?' predicate and the 'operator' and 'operands' procedures
;in the evaluator. Here is how we can do it:
(define (application? exp)
    (and (pair? exp) (eq? (car exp) 'call)))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))
