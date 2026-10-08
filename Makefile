# Builds the main resume and every tailored variant in variants/.
# PDFs land in pdf/ (gitignored); CI publishes them to GitHub Pages.

MAIN = ResumeAAE
BUILD_DIR = bin
PDF_DIR = pdf

VARIANT_SRCS = $(wildcard variants/*.tex)
VARIANT_PDFS = $(patsubst variants/%.tex,$(PDF_DIR)/%.pdf,$(VARIANT_SRCS))

all: $(PDF_DIR)/$(MAIN).pdf $(VARIANT_PDFS)

$(BUILD_DIR) $(PDF_DIR):
	mkdir -p $@

$(PDF_DIR)/$(MAIN).pdf: $(MAIN).tex | $(BUILD_DIR) $(PDF_DIR)
	latexmk -pdf -output-directory=$(BUILD_DIR) $(MAIN).tex
	mv $(BUILD_DIR)/$(MAIN).pdf $(PDF_DIR)/

$(PDF_DIR)/%.pdf: variants/%.tex | $(BUILD_DIR) $(PDF_DIR)
	latexmk -pdf -output-directory=$(BUILD_DIR) $<
	mv $(BUILD_DIR)/$*.pdf $(PDF_DIR)/

clean:
	latexmk -C -output-directory=$(BUILD_DIR)
	rm -rf $(BUILD_DIR)/*

.PHONY: all clean
