#lang at-exp racket

(require "../template.rkt")

; deliberately ignore the title
(provide title)
(define title "Second post") 

@render{
This is going to be the second post!
}