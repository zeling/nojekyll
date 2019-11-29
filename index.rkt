#lang at-exp racket

(require file/glob
         racket/system
         racket/date
         "template.rkt")

(struct post (name title time))

(define ($ cmd . args)
    (with-output-to-string (lambda ()
        (apply system* `(,(find-executable-path cmd) ,@args)))))

;; This is a dirty hack... Wish I had a better way
(define (get-attr path sym default)
    (with-handlers ([(lambda (v) #t) (lambda (v) default)])
        (with-output-to-file "/dev/null" #:exists 'append
            (lambda () (dynamic-require path sym)))))

(define (string->seconds str)
    (let ([parts (map string->number (string-split str "-"))])
        (apply find-seconds `(0 0 0 ,@(reverse parts)))))

(define (posts)
    (define (to-name p)
        (path->string (file-name-from-path p)))
    (define (post-order p1 p2)
        (< (string->seconds (post-time p1)) (string->seconds (post-time p2))))
    (let ([posts (for/list ([path (glob "posts/*.rkt")])
            (let ([title (get-attr path 'title "No title")]
                [time ($ "git" "log" "-n" "1" "--pretty=%ad" "--date" "short" (path->string path))]
                [name (to-name path)])
            (post name title (string-trim time))))])
        (sort posts post-order)))


(define (post-link p)
    (define (post-link name)
        (string-append "/posts/" (path->string (path-replace-extension name ".html"))))
    @a[class: "article-item" href: (post-link (post-name p))]{
        @span[class: "article-main"]{@(post-title p)}
        @span[class: "article-aux"]{@(post-time p)}
    })

@render{
    @div[class: "article"]{
        @h2{Articles}
        @ul[class: "article-list"]{
            @(for/list ([post (posts)])
                @li{@(post-link post)}
            )
        }
    }
}

