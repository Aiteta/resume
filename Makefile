# Builds the main resume, every tailored variant in variants/,
# and every cover letter in cover-letters/.
# PDFs land in pdf/ (gitignored): variants under pdf/variants/,
# cover letters under pdf/cover-letters/.
#
# Filenames are the output names: AAitEttajer<Company><PositionShorthand>,
# cover letters append -CoverLetter.

MAIN_SRC = ResumeAAE
MAIN_PDF = AAitEttajer
BUILD_DIR = bin
PDF_DIR = pdf

VARIANT_SRCS = $(wildcard variants/*.tex)
VARIANT_PDFS = $(patsubst variants/%.tex,$(PDF_DIR)/variants/%.pdf,$(VARIANT_SRCS))

COVER_SRCS = $(wildcard cover-letters/*.tex)
COVER_PDFS = $(patsubst cover-letters/%.tex,$(PDF_DIR)/cover-letters/%.pdf,$(COVER_SRCS))

all: $(PDF_DIR)/$(MAIN_PDF).pdf $(VARIANT_PDFS) $(COVER_PDFS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(PDF_DIR):
	mkdir -p $(PDF_DIR) $(PDF_DIR)/variants $(PDF_DIR)/cover-letters

$(PDF_DIR)/$(MAIN_PDF).pdf: $(MAIN_SRC).tex | $(BUILD_DIR) $(PDF_DIR)
	latexmk -pdf -output-directory=$(BUILD_DIR) $(MAIN_SRC).tex
	mv $(BUILD_DIR)/$(MAIN_SRC).pdf $(PDF_DIR)/$(MAIN_PDF).pdf

$(VARIANT_PDFS): $(PDF_DIR)/variants/%.pdf: variants/%.tex | $(BUILD_DIR) $(PDF_DIR)
	latexmk -pdf -output-directory=$(BUILD_DIR) $<
	mv $(BUILD_DIR)/$*.pdf $(@D)/

$(COVER_PDFS): $(PDF_DIR)/cover-letters/%.pdf: cover-letters/%.tex | $(BUILD_DIR) $(PDF_DIR)
	latexmk -pdf -output-directory=$(BUILD_DIR) $<
	mv $(BUILD_DIR)/$*.pdf $(@D)/

clean:
	latexmk -C -output-directory=$(BUILD_DIR)
	rm -rf $(BUILD_DIR)/*

.PHONY: all clean
