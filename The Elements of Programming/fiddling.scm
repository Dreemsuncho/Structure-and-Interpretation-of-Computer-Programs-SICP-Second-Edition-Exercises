;; 01: How many times is the procedure p applied when (sine 12.15) is evaluated?
;; As we see we can use substitution model to help us and the answer is 5 times.

(sine 12.15)
(p (sine 4.05))
(p (p (sine 1.35)))
(p (p (p (sine 0.45))))
(p (p (p (p (sine 0.15)))))
(p (p (p (p (p 0.05)))))


;; 02: What is the order of growth in space and number of steps (as a function of a) used by the process generated by the sine procedure when (sine a) is evaluated?
(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

;; This should be easy to answer, because we see very clear that till absolute angle is greater than 0.1 we just recur to sine, but with 3 times less input, also we see that only one call is made from sine to itself, all other operations are constant regardless of the cube and p procedures that we apply and thus we can say that our orders of space and time/steps is O(log n)



;; 1.16

(define (exp b n)
  (exp-iter b n 1))

(define (even? n)
  (= (remainder n 2) 0))

(define (square x)
  (* x x))

(define (exp-iter b n prod)
  (cond ((= n 0) prod)
	((even? n) (exp-iter (square b) (/ n 2) prod))
	(else (exp-iter b (- n 1) (* b prod)))))


(exp-iter 2 4 1)
(exp-iter 4 2 1)
(exp-iter 16 1 1)
(exp-iter 16 0 16)
16


(exp-iter 3 5 1)
(exp-iter 3 4 3)
(exp-iter 9 2 3)
(exp-iter 81 1 3)
(exp-iter 81 0 243)
243



;; 1.17
(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

(define (mul a b)
  (cond ((= b 0) 0)
	((even? b) (mul (double a) (halve b)))
	(else (+ a (mul a (- b 1))))))

(define (double x)
  (* x 2))
(define (halve x)
  (/ x 2))


(mul 3 7)


;; 1.18
(define (even? n)
  (= (remainder n 2) 0))

(define (double x)
  (* x 2))
(define (halve x)
  (/ x 2))

(define (mul-fast a b)
  (mul-iter a b 0))

(define (mul-iter a b prod)
  (cond ((or (= a 0) (= b 0)) 0)
	((= b 1) (+ a prod))
	((even? b) (mul-iter (double a)
			     (halve b)
			     prod))
	(else (mul-iter a (- b 1) (+ a prod))))
  )

(mul-fast 2 2 0)
(mul-fast 4 1 0)
4




;; 1.19

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) 
         b)
        ((even? count)
         (fib-iter a
                   b
                   ()  ;compute p'
                   ()  ;compute q'
                   (/ count 2)))
        (else 
         (fib-iter (+ (* b q) 
                      (* a q) 
                      (* a p))
                   (+ (* b p) 
                      (* a q))
                   p
                   q
                   (- count 1)))))



a ← bq + aq + ap
b ← bp + aq

a' ← (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
a' ← (bpq + aqq) + (bqq + aqq + apq) + (bqp + aqp + app)
a' ← 2bpq + 2aqq + 2apq + app + bqq

b' ← (bp + aq)p + (bq + aq + ap)q
b' ← (bpp + aqp) + (bqq + aqq + apq)
b' ← 



;; 1.20

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


;; Normal order

(gcd 206 40)

(if (= 40 0)
    206
    (gcd 40
	 (remainder 206 40)))

; 1 remainder = 1 total
(if (= (remainder 206 40) 0)
(if (= 6 0)
    40
    (gcd (remainder 206 40)
	 (remainder 40 (remainder 206 40))))

; + 2 remainder = 3 total
(if (= (remainder 40 (remainder 206 40)) 0)
(if (= 4 0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
	 (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

; + 4 remainder = 7 total
(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
(if (= 2 0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
	 (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))

; + 7 remainder = 14 total
(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
(if (= 0 0)
    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
    ;; + 4 remainders = 18 total
    (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
	 (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))

;; And thus we can calculate very easy that normal order uses 18 remainder evaluations




;; Applicative order
(gcd 206 40)
(gcd 40 (remainder 206 40))
(gcd 40 6)
(gcd 6 (remainder 40 6))
(gcd 6 4)
(gcd 4 (remainder 6 4))
(gcd 4 2)
(gcd 2 (remainder 4 2))
(gcd 2 0)
2

;; This example is more obvious and we count 4 remainder operations.





;; 1.21
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x)
  (* x x))

(smallest-divisor 199) ; => 199 Prime
(smallest-divisor 1999) ; => 1999 Prime
(smallest-divisor 19999) ; => 7 Not prime



;; 1.22
(require sicp)

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (square x)
  (* x x))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (cond ((prime? n)
	 (newline)
	 (display n)
	 (report-prime (- (runtime) 
			  start-time)))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start end)
  (cond ((even? start)
	 (search-for-primes (+ start 1) end))
	((< start end)
	 (timed-prime-test start)
	 (search-for-primes (+ start 2) end)))
  )

  (define (test min max tests-count)
    (define (run times)
      (cond ((> times 0)
	     (newline)
	     (search-for-primes min max)
	     (run (- times 1)))))
    
    (run tests-count)
    )


  (define (test-pretty min max tests-count)
    (test 10000000000000 10000000000100 3))
    
(test-pretty 1000000000000 1000000000064 6)
(test-pretty 10000000000000 10000000000100 1)
(test-pretty 100000000000000 100000000000098 1)
(test-pretty 1000000000000000 1000000000000160 1)
(test-pretty 10000000000000000 10000000000000080 1)
