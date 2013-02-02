(define (containsAnywhere elementToFind inList)
  (cond ((null? inList) #f)
        ((list? inList) (or (containsAnywhere elementToFind (first inList))
                             (containsAnywhere elementToFind (rest inList))))
        (else (eq? elementToFind inList))))
                             

(define (unitTest)
  (and 
   (containsAnywhere 'a '(a))
   (containsAnywhere 'a '(b a))
   (not (containsAnywhere 'a '(c d)))
   (containsAnywhere 'a '((a) b))
   (containsAnywhere 'b '((c d e) (g b e)))
   (containsAnywhere 'b '((c d e) (g (b) e)))
   (not (containsAnywhere 'x '((c d e) (g (b) e))))
   (containsAnywhere 'f '((c d e) (g (b) e) f))
   (not (containsAnywhere 'h '((c d e) (g (b) e) f)))
   ))

(display "Results from unitTest: ")
(unitTest)

(define (removeAll elementToRemove inList)
  (cond ((null? inList) '())
        ((list? inList) (append (list(removeAll elementToRemove (first inList)))
                                (removeAll elementToRemove (rest inList))))
        ((not (eq? elementToRemove inList)) inList)))

(define (unitTest2)
  (and 
   (equal? (removeAll 'a '(b a c)) '(b c))
   (equal? (removeAll 'a '((b a c d))) '((b c d)))
   (equal? (removeAll 'b '((b a c d (f)))) '((a c d (f))))
   (equal? (removeAll 'b '((b a c d (f b)))) '((a c d (f))))
   (equal? (removeAll 'b '((b a c d (f (b))))) '((a c d (f ()))))
   (equal? (removeAll 'b '((b a c d (f (b g))))) '((a c d (f (g)))))
   ))

(display "Results from unitTest2: ")
(unitTest2)