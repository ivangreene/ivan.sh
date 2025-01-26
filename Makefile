.DELETE_ON_ERROR:
all: pages biz-card-img pub/style.css

.PHONY: watch
watch:
	nodemon -e md,css,jpeg --ignore pub --watch . --watch Makefile --exec $(MAKE)

.PHONY: biz-card-img
biz-card-img: pages
	cp biz-cards/*.jpeg pub/biz-cards

pub/style.css: style.css pub gen-highlight-css.sh highlight.theme
	cp style.css pub/style.css
	./gen-highlight-css.sh >> pub/style.css

.PHONY: pages
pages:
	find * -name '*.md' | xargs -n1 ./build-page.sh

pub:
	mkdir pub
