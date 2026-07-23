;;Exercise 5.2: Use the register-machine language to describe the iterative factorial
;;machine of Exercise 5.1
(data-paths
    (registers
        ((name p)
         (buttons ((name *->p) (source (reg p) (reg c))))
         (buttons ((name 1->p) (source (cons 1)))))
        ((name c)
         (buttons ((name +->c) (source (reg c) (const 1))))
         (buttons ((name 1->c) (source (const 1)))))
        ((name n)))
    (operations
        ((name *) (inputs (reg p) (reg c)))
        ((name +) (inputs (reg c) (const 1)))
        ((name >) (inputs (reg c) (reg n)))))
(controller
    (assign p (constant 1))                         ; initialize p to 1
    (assign c (constant 1))                         ; initialize c to 1
    test-c                                          ; label
        (test (op >) (register c) (register n))     ; test
        (branch (label factorial-done))             ; conditional branch
        (assign p (op *) (register p) (register c)) ; multiply p by c
        (assign c (op +) (register c) (constant 1)) ; increment c
        (goto (label test-c))                       ; loop back to test
    factorial-done)                                 ; label