dst/%.html: src/%.md
	mkdir -p $$(dirname $@)
	cat $< | ./entry-html > $@
