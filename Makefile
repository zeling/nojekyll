RACKET := racket
POSTS  := posts

POSTS_SRC := $(shell find $(POSTS) -name "*.rkt")
POSTS_OUT := $(patsubst $(POSTS)/%.rkt,$(POSTS)/%.html,$(POSTS_SRC))

.PHONY: all clean dbg

all: index.html about.html $(POSTS_OUT)

clean:
	rm -f $(POSTS_OUT) index.html about.html

%.html: %.rkt template.rkt
	$(RACKET) -t $< > $@

dbg:
	@echo $(POSTS_OUT)