#lang racket/base

(require "ast.rkt"
         racket/match)

(provide calc-analyze)

(define (analyze-instr instr env)
  (match instr
    ((Pval val)
     #t)
    ((Pid name)
     (if (hash-has-key? env name)
         #t
         (begin
           (eprintf "Undefined variable: ~a\n" name)
           (exit 1))))
    ((Pdef id expr)
     (hash-set env id (analyze-instr expr env)))
    ((Pop _ v1 v2)
     (and (analyze-instr v1 env) (analyze-instr v2 env)))))

(define (calc-analyze prog env)
  (match prog
    ((list expr)
     (analyze-instr expr env))
    ((cons decl prog-rest)
     (calc-analyze prog-rest (analyze-instr decl env)))))

