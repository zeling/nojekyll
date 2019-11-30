#lang at-exp racket/base

(require "template.rkt")

@render{
    @h2{About this site}
    @p{
        This site initially serves as a proof of concept that we don't need static site generators to write blogs, instead
        we can make the process really easy with Makefile and @a[href: "https://racket-lang.org"]{a good programming language}.
        I plan to explain this in the near future and make it to be the first post of this blog.
    }
    @p{
        I am not a web designer, so please bear with me for the terrible web design. I tried to make the content more readable, the CSS stylesheet 
        of this site is based on (blatantly copied from) @a[href: "http://bettermotherfuckingwebsite.com/"]{this site}. The good news is that unlike
        some other sites, I won't add any random particle effects whose meaning remains unclear.
    }
    @p{
        Opinions expressed are solely my own and do not express the views or opinions of my employer.
    }

    @h2{About me}
    @p{
        I am a programmer currently living in the US. You can find my other online identities from @a[href: "https://keybase.io/zeling"]{Keybase}.
    }
}