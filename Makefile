# Makefile for volume.sh

PREFIX = /usr/local
PGM = volume
PGM_ALT = mute
PGM_MAN = $(PGM).1
PGM_ALT_MAN = $(PGM_ALT).1
PGM_BINDIR = $(DESTDIR)$(PREFIX)/bin
PGM_MANDIR = $(DESTDIR)$(PREFIX)/man/man1
PGM_FILES = $(PGM) $(PGM_MAN) Makefile README.txt LICENSE.txt

INSTALL=/usr/bin/install -c

all:
	@echo Nothing to do

install:
	mkdir -p $(PGM_BINDIR) $(PGM_MANDIR)
	$(INSTALL) $(PGM).sh $(PGM_BINDIR)/$(PGM)
	cd $(PGM_BINDIR) && /bin/ln -s $(PGM) $(PGM_ALT)
	$(INSTALL) -m 0644 $(PGM_MAN) $(PGM_MANDIR)/$(PGM_MAN)
	cd $(PGM_MANDIR) && /bin/ln -s $(PGM_MAN) $(PGM_ALT_MAN)

uninstall:
	/bin/rm $(PGM_BINDIR)/$(PGM) \
            $(PGM_BINDIR)/$(PGM_ALT) \
            $(PGM_MANDIR)/$(PGM_MAN) \
            $(PGM_MANDIR)/$(PGM_ALT_MAN)

clean:
	/bin/rm -f *.o *~ core .DS_Store $(PGM_MAN).txt

man2txt: $(PGM).1.txt

$(PGM).1.txt:
	nroff -Tascii -man $(PGM).1 | col -b -x > $(PGM).1.txt

