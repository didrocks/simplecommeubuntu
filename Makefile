#********************************************************
# Makefile for LaTeX documents
#
# Copyright 2009 by Didier Roche <didrocks@ubuntu.com>
#
# Provided under the terms of CC:BY-SA
#*******************************************************

DOC = maitre
VERSION = $$(sed -n 's/\\def\\version{v \(.*\)}/\1/p' main/VotreFramabook.sty | sed 's/ //g')

.PHONY: install all clean proper

all build: $(DOC).pdf

$(DOC).pdf: $(DOC).tex
	while ( \
        makeindex -s framabook/glossaire.ist $(DOC).glo -o $(DOC).glx ; \
        makeindex -s framabook/index.ist $(DOC) ; \
		pdflatex -interaction=nonstopmode $(DOC).tex || true ; \
		grep -q "get cross-references right" $(DOC).log ) do true ; \
	done

clean:
	for i in "." "*" "*/*" ; do \
		rm -rf $$i/*~ ; \
		rm -rf $$i/*.aux ; \
	    rm -rf $$i/*.glo ; \
		rm -rf $$i/*.gls ; \
	    rm -rf $$i/*.idx ; \
		rm -rf $$i/*.ilg ; \
	    rm -rf $$i/*.ind ; \
		rm -rf $$i/*.lof ; \
	    rm -rf $$i/*.log ; \
		rm -rf $$i/*.lot ; \
	    rm -rf $$i/*.out ; \
		rm -rf $$i/*.toc ; \
	    rm -rf $$i/*.som ; \
	done ;
	rm -f $(DOC).pdf

install: $(DOC).pdf
	if [ "$(DESTDIR)" != "" ] ; then \
		mkdir -p $(DESTDIR) ; \
		cp $(DOC).pdf $(DESTDIR)/scu-$(VERSION).pdf ; \
	else \
		cp $(DOC).pdf ./scu-$(VERSION).pdf ; \
	fi

