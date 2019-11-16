RACKET := racket
POSTS  := posts

POSTS_SRC := $(shell find $(POSTS) -name "*.rkt")
POSTS_OUT := $(patsubst $(POSTS)/%.rkt,$(POSTS)/%.html,$(POSTS_SRC))

.PHONY: all clean dbg

all: about.html $(POSTS_OUT)

clean:
	rm -f $(POSTS_OUT)

%.html: %.rkt template.rkt
	rm -f $@
	$(RACKET) -t $< > $@

dbg:
	@echo $(POSTS_OUT)