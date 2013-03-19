(define list1 `(1 6 8 3 10))

(define (oddElements inList)
  (cond ((null? inList) '())
        ((null? (rest inList)) (list (first inList)))
        (else (append (list (first inList)) (oddElements (cddr inList))))))

(define (evenElements inList)
  (cond ((null? inList) '())
        ((null? (rest inList)) '())
        ((null? (cddr inList)) (list (cadr inList)))
        (else (append (list (cadr inList)) (evenElements (cddr inList))))))

(define (mergeLists list1 list2)
  (cond ((null? list2) list1)
        ((null? list1) list2)
        ((> (first list1) (first list2)) (append (list (first list2)) (mergeLists list1 (rest list2))))
        (else (append (list (first list1)) (mergeLists (rest list1) list2)))))