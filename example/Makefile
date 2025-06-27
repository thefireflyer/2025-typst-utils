WATCHMAKE=target
export WATCHMAKE

.PHONY: all watch

all: target

watch:
	@while true; do \
		make -s $(WATCHMAKE); \
		inotifywait -qqre close_write .; \
	done

clean:
	@rm -rf .entangled
	@rm -rf target

target/%.pdf: %.pdf
	@mv $< $@

%.pdf: doc/%.typ target
	@typst compile $<

target: .entangled/build/Makefile doc/*.typ
	@make -s -f .entangled/build/Makefile

.entangled/build/Makefile: doc/*.typ
	@cd doc
	@entangled tangle
	@cd ..
