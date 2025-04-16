TEX = ResumeAAE
BUILD_DIR = build
PDF_DIR = pdf

all: $(PDF_DIR)/$(TEX).pdf

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(PDF_DIR):
	mkdir -p $(PDF_DIR)

$(PDF_DIR)/$(TEX).pdf: $(TEX).tex | $(BUILD_DIR) $(PDF_DIR)
	latexmk -pdf -output-directory=$(BUILD_DIR) $(TEX).tex
	mv $(BUILD_DIR)/$(TEX).pdf $(PDF_DIR)/

clean:
	latexmk -C -output-directory=$(BUILD_DIR)
	rm -rf $(BUILD_DIR)/*
