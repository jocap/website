dst/%.html: src/%.md
	mkdir -p $$(dirname $@)
	cat $< | bin/html-page > $@

dst/%.html: src/%.html
	mkdir -p $$(dirname $@)
	cp $< $@

dst/index.html:
	mkdir -p dst
	bin/html-index > $@

dst/atom.xml:
	mkdir -p dst
	bin/atom-index > $@

all:
	bin/make-all
