.DELETE_ON_ERROR:
all: pub/index.html pub/style.css

pub/style.css: style.css pub
	cp style.css pub/style.css

pub/index.html: index.md top.html bottom.html pub
	cp top.html pub/index.html
	markdown index.md >> pub/index.html
	cat bottom.html >> pub/index.html

pub:
	mkdir pub
