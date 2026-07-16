;Exercise 4.56: Formulate compound queries that retrieve the following information:
;a. the names of all people who are supervised by Ben Bitdiddle, together with their addresses;
(and (supervisor ?x (Bitdiddle Ben)) (address ?x ?y))
;b. all people whose salary is less than Ben Bitdiddle’s, together with their salary and Ben Bitdiddle’s salary;
(and (salary ?x ?y) (salary (Bitdiddle Ben) ?z) (lisp-value < ?y ?z))
;c. all people who are supervised by someone who is not in the computer division, together with the supervisor’s name and job.
(and (supervisor ?x ?y) (not (job ?y (computer . ?z))))