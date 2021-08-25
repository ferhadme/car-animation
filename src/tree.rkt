#lang racket

(require 2htdp/image)
(require "car.rkt") ;; for wheel radius

(define TREE-COEFF (* WHEEL-RADIUS 2))
(define TREE
  (underlay/xy (circle TREE-COEFF "solid" "green")
               (- TREE-COEFF (/ TREE-COEFF 10)) (* TREE-COEFF 1.5)
               (rectangle (/ TREE-COEFF 5) (* TREE-COEFF 2.5) "solid" "brown")))

(provide TREE)
