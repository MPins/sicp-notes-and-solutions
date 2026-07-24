(controller
    sqrt-loop
        (assign x (op read))
        (assign g (const 1.0))
    test-ge
        (assign t (op mul) (reg g) (reg g))
        (assign t (op sub) (reg t) (reg x))
        (assign t (op abs) (reg t))
        (test (op <) (reg t) (const 0.00001))
        (branch (label sqrt-done))
        (assign t (op div) (reg x) (reg g))
        (assign g (op average) (reg t) (reg g))
        (goto (label test-ge))
    sqrt-done
        (perform (op print) (reg g))
        (goto (label sqrt-loop)))