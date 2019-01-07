title := John Ankarström
author := John Ankarström
base := file:///home/john/Sites/sh/dst
export title author base

dst/%.html: src/%.md bin/html-page bin/html-page-tpl
	mkdir -p $$(dirname $@)
	cat $< | bin/html-page > $@

dst/%: src/%
	mkdir -p $$(dirname $@)
	cp $< $@

dst/index.html: bin/html-index bin/html-index-tpl
	mkdir -p dst
	bin/html-index > $@

dst/atom.xml: bin/atom-index bin/atom-index-tpl
	mkdir -p dst
	bin/atom-index > $@

all:
	bin/make-all

site: all dst/index.html dst/atom.xml
