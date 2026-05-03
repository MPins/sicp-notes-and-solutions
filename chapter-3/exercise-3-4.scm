;guile 3.0.9
;Exercise 3.4: Modify the make-account procedure of Exercise 3.3 by adding another
;local state variable so that, if an account is accessed more than seven consecutive
;times with an incorrect password, it invokes the procedure call-the-cops.
(define (make-account balance secret-password)
	(define concecutive-wrong-password 0)
	(define (check-password password)
		(if (eq? password secret-password)
			(begin
				(set! concecutive-wrong-password 0)
				#t)
			(begin
				(set! concecutive-wrong-password (+ 1 concecutive-wrong-password))
				(if (= concecutive-wrong-password 7)
					(call-the-cops)
					#f))))
	(define (withdraw amount)
		(if (>= balance amount)
			(begin  (set! balance (- balance amount))
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
((acc 'snip 'withdraw) 40)
((acc 'snip 'withdraw) 40)
((acc 'snip 'withdraw) 40)
((acc 'snip 'withdraw) 40)
((acc 'snip 'withdraw) 40)
((acc 'snip 'withdraw) 40)
