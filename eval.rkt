#lang racket/base

(require "ast.rkt"
         racket/match)

(provide calc-eval)

(define (eval-instr instr env)
  (match instr
    ((Pval val)
     val)
    ((Pid name)
     (hash-ref env name))
    ((Pdef id expr)
     (hash-set env id (eval-instr expr env)))
    ((Pop op v1 v2)
     (match op
       ('add (+ (eval-instr v1 env) (eval-instr v2 env)))
       ('sub (- (eval-instr v1 env) (eval-instr v2 env)))
       ('mul (* (eval-instr v1 env) (eval-instr v2 env)))
       ('div (/ (eval-instr v1 env) (eval-instr v2 env)))))))

(define (calc-eval prog env)
  (match prog
    ((list expr)
     (eval-instr expr env))
    ((cons decl prog-rest)
     (calc-eval prog-rest (eval-instr decl env)))))
