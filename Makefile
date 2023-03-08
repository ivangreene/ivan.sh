index.html: index.md top.html bottom.html style.css
	markdown index.md > _index.html
	cat top.html _index.html bottom.html > index.html
	rm _index.html
