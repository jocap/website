title ?= John Ankarström
author ?= John Ankarström
lang ?= en
base ?= https://john.ankarstrom.se/
export title author lang base

docs/%.html: src/%.md bin/html-page bin/html-page-tpl
	mkdir -p $$(dirname $@)
	cat $< | bin/html-page > $@

docs/%: src/%
	mkdir -p $$(dirname $@)
	cp $< $@

docs/index.html: bin/html-index bin/html-index-tpl bin/html-page-tpl
	mkdir -p docs
	bin/html-index > $@

docs/atom.xml: bin/atom-index bin/atom-index-tpl
	mkdir -p docs
	bin/atom-index > $@

all:
	bin/make-all

site: all docs/index.html docs/atom.xml
