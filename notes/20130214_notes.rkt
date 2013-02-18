(define (cl x)
  [let* ((z 5) (y 20) (fn (lambda (x) (* x y z))))
    (let ((y 10))
      (fn y))])

(define (cl_4 x y z)
  (let * [(y 7) (fn (lambda (x) (+ x y z)))]
    (let [(z 1)]
      (set! y 5)
      (set! z 3)
      (fn z))))

(define (fnlst c)
  (let ((a 3) (b 5))
    (list (lambda (x) (set! a (+ a b c)) (+ a b c x))
          (lambda (x) (set! b (- a b c)) (+ a b c x)))))

(define (jj x y)
  (let [(fns (fnlst x))]
    (let [(jack (car fns)) (jill (cadr fns))]
      (display "Jack-Jill-Jack-Jill\n")
      (display "Jack: ") (display (jack y)) (display "\n")
      (display "Jill: ") (display (jill y)) (display "\n")
      (display "Jack: ") (display (jack y)) (display "\n")
      (display "Jill: ") (display (jill y)) (display "\n")))
  (let [(fns (fnlst x))]
    (let [(jack (car fns)) (jill (cadr fns))]
      (display "Jack-Jill-Jill-Jack\n")
      (display "Jack: ") (display (jack 2)) (display "\n")
      (display "Jill: ") (display (jill 2)) (display "\n")
      (display "Jill: ") (display (jill 2)) (display "\n")
      (display "Jack: ") (display (jack 2)) (display "\n"))))

(jj 3 2)