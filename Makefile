USCAN=/usr/bin/uscan

all: download

download:
ifeq ($(shell dpkg --print-architecture),amd64)
	$(USCAN) --download --watchfile debian/watch.amd64 --download-current-version --destdir . --no-symlink
	tar -jxvf thunderbird-*.tar.bz2 -C opt
	mv opt/thunderbird opt/thunderbird-bin
	rm -f thunderbird-*.tar.bz2
else ifeq ($(shell dpkg --print-architecture),i386)
	$(USCAN) --download --watchfile debian/watch.i386 --download-current-version --destdir . --no-symlink
	tar -jxvf thunderbird-*.tar.bz2 -C opt
	mv opt/thunderbird opt/thunderbird-bin
	rm -f thunderbird-*.tar.bz2
else
	@echo "architecture not specified, try for example i686 or x86_64\n"
endif

clean:
	rm -f thunderbird-*
	rm -rf opt/thunderbird
	rm -rf opt/thunderbird-bin

install:

	mkdir -pv $(DESTDIR)
	cp -a opt usr $(DESTDIR)/.

.PHONY: download clean
