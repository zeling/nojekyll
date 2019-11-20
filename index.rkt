#lang at-exp racket

(require file/glob
         racket/system
         "template.rkt")

(struct post (name title time))

(define ($ cmd . args)
    (with-output-to-string (lambda ()
        (apply system* `(,(find-executable-path cmd) ,@args)))))

;; This is a dirty hack... Wish I had a better way
(define (get-attr path sym)
    (with-output-to-file "/dev/null" #:exists 'append
        (lambda () (dynamic-require path sym))))

(define (posts)
    (define (to-name p)
        (path->string (file-name-from-path p)))
    (for/list ([path (glob "posts/*.rkt")])
        (let ([title (get-attr path 'title)]
              [time ($ "git" "log" "-n" "1" "--pretty=%ad" "--date" "short" (path->string path))]
              [name (to-name path)])
        (post name title (string-trim time)))))

(define (post-link p)
    (define (post-link name)
        (string-append "/posts/" (path->string (path-replace-extension name ".html"))))
    @a[href: (post-link (post-name p))]{@(string-append (post-title p) " " (post-time p))})

@render{
    @ul{
        @(for/list ([post (posts)])
            @li{@(post-link post)}
        )
    }
}

