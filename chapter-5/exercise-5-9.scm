;guile 3.0.9
;; Load journal/register-machine-simulator-v1.scm before this file:
;; it redefines make-operation-exp from that simulator.

;;Exercise 5.9: The treatment of machine operations above permits them to
;;operate on labels as well as on constants and the contents of registers.
;;Modify the expression-processing procedures to enforce the condition that
;;operations can be used only with registers and constants.

;; Where the hole is
;
; make-operation-exp maps make-primitive-exp over its operands, and
; make-primitive-exp accepts (label x) just like (reg x) and (const x):
; it returns a procedure yielding the instruction sequence that starts at
; that label.  So a controller such as
;
;   (assign a (op +) (const 1) (label here))
;
; assembles without complaint and then hands a list of instructions to +.
;
; The check belongs in make-operation-exp, NOT in make-primitive-exp: a
; bare (label here) is still legitimate elsewhere -- (goto (label here))
; and (assign continue (label after-call)) both depend on it.  Only the
; OPERANDS of an operation must be restricted.
;
; Doing it here, outside the returned lambda, also means the error is
; raised once at assembly time rather than on every execution of the
; instruction.
(define (make-operation-exp exp machine labels operations)
	(let ((op (lookup-prim (operation-exp-op exp)
	                        operations))
	      (aprocs
	        (map (lambda (e)
	                (if (label-exp? e)
	                    (error "Operation used with a label: ASSEMBLE" exp)
	                    (make-primitive-exp e machine labels)))
	             (operation-exp-operands exp))))
	 (lambda ()
	    (apply op (map (lambda (p) (p)) aprocs)))))