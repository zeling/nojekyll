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
        @h1{Zeling's Blog}
        @hr
        @(navbar "index" "about")
        @hr
    })

(define (footer)
    @div[class: "footer"]{
        @hr
        @div[class: "license"]{
            @a[rel: "license" href: "http://creativecommons.org/licenses/by-sa/4.0/"]{
                @img[alt: "Creative Commons License" style: "border-width:0" src: "https://i.creativecommons.org/l/by-sa/4.0/88x31.png"]
            }
            This work is licensed under a @a[rel: "license" href: "http://creativecommons.org/licenses/by-sa/4.0/"]{Creative Commons Attribution-ShareAlike 4.0 International License}.
        }
    })

(define (navbar . parts)
    (define (col name)
        @div{
            @a[href: @(string-append "/" name ".html")]{@name}
        })
    @div[class: "navbar"]{
        @(for/list ([part parts])
            @col{@part})
    })
