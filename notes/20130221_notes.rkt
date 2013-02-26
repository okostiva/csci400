;CLOSURES
;MAP
;CURRYING

(define (fn a)
  a)

;Map can only be used on functions that require only one argument
(map fn '(a b c))
(list (fn 'a) (fn 'b) (fn 'c))

(define values '(15 3 7 42 91))
;Elements greater than 10
;(#t #f #f #t #t)
(map [lambda (x) (> x 10)] values)

;y is a free variables as it was not passed to the lambda function, 
;so it will capture its value from its lexial scope or CLOSURE
(define (threshold x y)
  ([lambda (x) (> x y)] x))

(map [lambda (x) (threshold x 10)] values)


;CURRYING is an example of using lexical scope and closures to execute
;a function that requires more than one variable with less variables then
;are required
(define (threshold y)
  [lambda (x) (> x y)])

(map (threshold 10) values)