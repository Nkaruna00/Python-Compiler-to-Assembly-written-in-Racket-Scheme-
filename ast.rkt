#lang racket/base

(provide (all-defined-out))

(struct Pval (val) #:transparent)
(struct Pid (name) #:transparent)
(struct Pop (op v1 v2) #:transparent)
(struct Pdef (id expr) #:transparent)