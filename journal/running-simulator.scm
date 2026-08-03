(load "../journal/register-machine-simulator-v2.scm")

(define m (make-machine
    '(a b t)
    (list (list 'rem remainder) (list '= =))
    '(test-b
        (test (op =) (reg b) (const 0))
        (branch (label gcd-done))
        (assign t (op rem) (reg a) (reg b))
        (assign a (reg b))
        (assign b (reg t))
        (goto (label test-b))
      gcd-done)))

(set-register-contents! m 'a 206)
(set-register-contents! m 'b 40)
(start m)
(display (get-register-contents m 'a))     ; = 2