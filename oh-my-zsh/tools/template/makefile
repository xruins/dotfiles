
LATEX = platex
DVIPDFM = dvipdfmx

PRODUCT = product

$(PRODUCT).dvi: $(PRODUCT).tex
	$(LATEX) -interaction=nonstopmode $(PRODUCT).tex
	$(LATEX) -interaction=nonstopmode $(PRODUCT).tex

$(PRODUCT).pdf: $(PRODUCT).dvi
	$(DVIPDFM) $(PRODUCT).dvi

all: $(PRODUCT).dvi

pdf: $(PRODUCT).pdf

clean:
	rm -rf *.dvi *.log *.aux

