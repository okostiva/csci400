(require racket/trace)

(define a 15)

(define bob
  (lambda (a) (cond ((< a 20) (display "Less than 20")) ((= a 5) (display "Equals 5")) (else (display "Something else")))))
(bob 27)

(define (sue a) (cond ((< a 20) (display "Less than 20")) ((= a 5) (display "Equals 5")) (else (display "Something else"))))
(sue 5)

(define (square x) (* x x))

(define (evenSquares inList1 inList2) 
  (if (null? inList1)
      '()
      (if (even? (first inList1))
          (append (append (list (square (first inList1))) inList2) (evenSquares (rest inList1) inList2))
          (evenSquares (rest inList1) inList2))))

(define (evenSquaresTF inList1 inList2) inList1)

(define (solution n)
  (if (< n 1)
      0
      (+ 1 (* 2 (solution (- n 1))))))

  
(define (userInfo)
  (display "Enter your name: ")
  (let ([name (read)])
    (display "Hello ")
    (display name)
    (display ", please enter your age: ")
    (let ([age (read)])
      (cond
        ((< age 20) (printf "You're young, ~a" name))
        ((< age 50) (display "How does it feel to be getting old?"))
        (else (display "You must be really old"))))))

(define (squareSquare x)
  (let* ([sq (square x)]
         [sq2 (square sq)])
    (if (eq? 0 (modulo sq2 4))
        (display "yes")
        (display "no"))))

(define happyMoods '(happy ecstatic swell))

(define (isHappy mood)
  (define (findHappy moodList)
    (cond ((null? moodList) #f)
          ((eq? mood (first moodList)) #t)
          (else (findHappy (rest moodList))))) 
  (findHappy happyMoods))
  
(define (checkOutFirst predicate moods)
  (apply predicate (list (first moods))))

(define (checkOutAll predicate moods)
  (cond ((null? moods) #f)
        ((checkOutFirst predicate moods) #t)
        (else (checkOutAll predicate (rest moods)))))

(define (checkOutFirstString inString moods)
  (let ([function (string->symbol inString)])
    (if (eq? function 'isHappy)
        (checkOutFirst isHappy moods)
        #f)))

(define (countElements inList)
  (cond ((null? inList) 0)
        ((list? inList) (+ (countElements (first inList)) (countElements (rest inList))))
        (else 1)))      

(define (replaceElement numToRep newElement inList outList)
  (cond ((null? inList) outList)
        ((= numToRep 1) (replaceElement (- numToRep 1) newElement (rest inList) (append outList (list newElement))))
        (else (replaceElement (- numToRep 1) newElement (rest inList) (append outList (list (first inList)))))))
