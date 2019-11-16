#lang at-exp racket

(provide render
         (all-from-out scribble/html))

(require scribble/html/xml
         scribble/html)


(define (render content)
    (output-xml @doctype{html})
    (output-xml (page content)))

(define (page content)
    @html{ 
        @head{
            @meta[charset: "UTF-8"]
            @link[rel: "stylesheet" href: "/style.css"]
        }
        @body{
            @header
            @content
            @footer
        }
    })

(define (header)
    @div[class: "header"]{
        @h1{Title}
        @hr
        @(navbar "posts/hello" "about")
        @hr
    })

(define (footer)
    @hr
    @p{Footer})

(define (navbar . parts)
    (define (col name)
        @div{
            @a[href: @(string-append "/" name ".html")]{@name}
        })
    @div[class: "navbar"]{
        @(for/list ([part parts])
            @col{@part})
    })

