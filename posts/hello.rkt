#lang at-exp racket/base

(require "../template.rkt")

(provide title)

(define title "First Post")

@render{
    @p{
        This is going to be the first post ever, hooray!
    }
}
