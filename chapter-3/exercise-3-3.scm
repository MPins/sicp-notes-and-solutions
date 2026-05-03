;guile 3.0.9
;Exercise 3.3: Modify the make-account procedure so that it creates password-protected accounts.
;that is, make-account should take a symbol as an additional argument, as in 
;(define acc (make-account 100 'secret-password))
;The resulting account object should process a request only if it is accompanied by the password
;with which the account was created, and should otherwise return a complaint:
(define (make-account balance secret-password)
	(define (check-password password) (eq? password secret-password))
	(define (withdraw amount)
		(if (>= balance amount)
			(begin (set! balance (- balance amount))
				balance)
			"Insufficient funds"))
	(define (deposit amount)
		(set! balance (+ balance amount))
		balance)
	(define (dispatch p m)
		(cond ((check-password p)
			(cond   ((eq? m 'withdraw) withdraw)
				    ((eq? m 'deposit) deposit)
				    (else (error "Unknown request: MAKE-ACCOUNT" m))))
			(else
				(lambda (amount) (format #t "Invalid password: ~a\n" p)))))
	dispatch)

(define acc (make-account 100 'pins))

(format #t "Balance after withdraw of 40 = ~a\n" ((acc 'pins 'withdraw) 40))
((acc 'snip 'withdraw) 40)

