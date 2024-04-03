prefix ?= /usr/local
bindir = $(prefix)/bin

build:
	swift build -c release --disable-sandbox

install: build
	install -d "$(bindir)"
	install ".build/release/atpctrl" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/atpctrl"

clean:
	rm -rf .build

.PHONY: build install uninstall clean
