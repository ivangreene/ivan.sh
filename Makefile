.DELETE_ON_ERROR:
all: pages pub/style.css

pub/style.css: style.css pub
	cp style.css pub/style.css

.PHONY: pages
pages: index.md top.html bottom.html pub
	find * -name '*.md' | xargs -n1 ./build-page.sh

pub:
	mkdir pub
