title ?= John Ankarström
author ?= John Ankarström
lang ?= en
base ?= https://john.ankarstrom.se
export title author lang base

.FORCE:

docs/%.html: src/%.md bin/html-page bin/html-page-tpl
	mkdir -p $$(dirname $@)
	cat $< | bin/html-page > $@

docs/%: src/%
	mkdir -p $$(dirname $@)
	cp $< $@

docs/index.html: .FORCE
	mkdir -p docs
	bin/html-index > $@

docs/atom.xml: .FORCE
	mkdir -p docs
	bin/atom-index > $@

pages:
	bin/make-pages

site: pages docs/index.html docs/atom.xml

all: site
