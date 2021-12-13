#lang racket

(require 2htdp/universe)
(require 2htdp/image)

(require "car.rkt")
(require "tree.rkt")

(define WIDTH 800)
(define HEIGHT 500)
(define ANIMATION-STATE 3)

(define (random-location width height)
  (tree-location (random (- width (image-width TREE))) (random-for-height height)))

(struct tree-location (x y))

;; y location of trees shouldn't be in road of car, that's why different random needed for y loc
(define (random-for-height n)
  (let* ([restricted-border (image-height CAR)]
         [rand-1 (random (- (/ n 2) (+ (image-height TREE) restricted-border)))]
         [rand-2 (random (+ (/ n 2) restricted-border) (- n (image-height TREE)))])
    (if (< (random) 0.5)
        rand-1
        rand-2)))

(define (generate-background n-of-trees)
  (define (iter counter obj)
    (let ([point (random-location WIDTH HEIGHT)])
      (if (= counter n-of-trees)
          obj
          (iter (+ counter 1)
                (overlay/xy TREE
                            (- (tree-location-x point))
                            (- (tree-location-y point))
                            obj)))))
  (iter 0 (empty-scene WIDTH HEIGHT)))
                          
(define bckround (generate-background 100))

(define (tock ws)
  (+ ws ANIMATION-STATE))

(define (render ws)
  (place-image
   CAR ws (/ HEIGHT 2)
   bckround))

(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))

(define (stop ws)
  (>= ws (- WIDTH (* WHEEL-RADIUS 4))))

(define (start-animation)
  (big-bang 0
            [on-tick tock]
            [to-draw render]
            [on-mouse hyper]
            [stop-when stop]))
