#lang racket

(require "parser.rkt")
(require "analyze.rkt")
(require "eval.rkt")

(define argv (current-command-line-arguments))
(cond
	((= (vector-length argv) 1)
   		(define in (open-input-file (vector-ref argv 0)))
   		(port-count-lines! in)
    	(define prog (parse_python in))
    	(close-input-port in)
   		(write prog))
			;(calc-analyze prog (make-immutable-hash))
			;(displayln (calc-eval prog (make-immutable-hash))))
(else
	(eprintf "Usage: racket main.rkt <src.py>\n")
   	(exit 1)))
