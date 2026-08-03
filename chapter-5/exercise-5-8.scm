;guile 3.0.9

;;Exercise 5.8: The following register-machine code is ambiguous, because the
;;label here is defined more than once:
;
; start
;   (goto (label here))
; here
;   (assign a (const 3))
;   (goto (label there))
; here
;   (assign a (const 4))
;   (goto (label there))
; there

;; Part 1: 
;;With the simulator as writen, what will the contents of register a be when
;;control reaches there?
;
; extract-labels recurses all the way to the end of the text BEFORE
; building any label entry, so the entries are consed while the
; recursion unwinds -- that is, in reverse textual order.  The first
; `here` of the text is therefore consed LAST and ends up at the FRONT
; of the labels list:
;
;   (map car labels) => (start here here there)
;                               ^ the textually first one
;
; lookup-label uses assoc, which returns the FIRST matching entry, so
; (goto (label here)) jumps to the first `here` and runs
; (assign a (const 3)).  Control then reaches `there` with a = 3.

;; Part 2: make the assembler reject a label name used twice.
;
; When extract-labels is about to add the entry for the label at
; position i, `labels` already holds every label that appears AFTER
; position i (that is what the recursion built).  So a plain assoc on
; the accumulated list is enough to spot a repeated name.
(define (extract-labels text receive)
	(if (null? text)
		(receive '() '())
		(extract-labels
			(cdr text)
			(lambda (insts labels)
				(let ((next-inst (car text)))
					(if (symbol? next-inst)
						(if (assoc next-inst labels)
							(error "Duplicated label: EXTRACT-LABELS"
								next-inst)
							(receive insts
								(cons (make-label-entry next-inst insts)
									  labels)))
						(receive (cons (make-instruction next-inst) insts)
								 labels)))))))
