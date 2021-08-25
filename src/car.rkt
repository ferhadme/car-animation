#lang racket

(require 2htdp/image)

(define WHEEL-RADIUS 10)

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define CAR-TOP
  (rectangle (* WHEEL-RADIUS 4) WHEEL-RADIUS "solid" "gray"))
(define CAR-CORE
  (rectangle (* WHEEL-RADIUS 8) (* WHEEL-RADIUS 2) "solid" "gray"))
(define CAR-BODY
  (overlay/xy CAR-CORE
              (* WHEEL-RADIUS 2) (- WHEEL-RADIUS)
              CAR-TOP))

(define CAR
  (overlay/xy WHEEL
              (- (* WHEEL-RADIUS 5)) (- (* WHEEL-RADIUS 2))
              (overlay/xy WHEEL
                          (- WHEEL-RADIUS) (- (* WHEEL-RADIUS 2))
                          CAR-BODY)))

(provide WHEEL-RADIUS CAR)
