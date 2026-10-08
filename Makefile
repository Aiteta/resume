# Builds the main resume, every tailored variant in variants/,
# and every cover letter in cover-letters/.
# PDFs land in pdf/ (gitignored): variants under pdf/variants/,
# cover letters under pdf/cover-letters/.
#
# Output filenames follow AAitEttajer<Company><PositionShorthand>;
# cover letters append -CoverLetter. Source .tex filenames are unchanged.

MAIN_SRC = ResumeAAE
MAIN_PDF = AAitEttajer
BUILD_DIR = bin
PDF_DIR = pdf

# variant stem -> output PDF name (no extension)
VARIANTS = temporal-oss temporal supabase netflix livekit clickhouse
VARIANT_PDF_temporal-oss = AAitEttajerTemporalOSS
VARIANT_PDF_temporal    = AAitEttajerTemporalCloud
VARIANT_PDF_supabase    = AAitEttajerSupabaseMultigres
VARIANT_PDF_netflix     = AAitEttajerNetflixL4
VARIANT_PDF_livekit     = AAitEttajerLiveKitDistSys
VARIANT_PDF_clickhouse  = AAitEttajerClickHouseCloudInfra
VARIANT_PDFS = $(foreach v,$(VARIANTS),$(PDF_DIR)/variants/$(VARIANT_PDF_$(v)).pdf)

# cover-letter stem -> output PDF name (no extension)
COVERS = temporal-oss temporal supabase netflix
COVER_PDF_temporal-oss = AAitEttajerTemporalOSS-CoverLetter
COVER_PDF_temporal    = AAitEttajerTemporalCloud-CoverLetter
COVER_PDF_supabase    = AAitEttajerSupabaseMultigres-CoverLetter
COVER_PDF_netflix     = AAitEttajerNetflixL4-CoverLetter
COVER_PDFS = $(foreach c,$(COVERS),$(PDF_DIR)/cover-letters/$(COVER_PDF_$(c)).pdf)

all: $(PDF_DIR)/$(MAIN_PDF).pdf $(VARIANT_PDFS) $(COVER_PDFS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(PDF_DIR):
	mkdir -p $(PDF_DIR) $(PDF_DIR)/variants $(PDF_DIR)/cover-letters

$(PDF_DIR)/$(MAIN_PDF).pdf: $(MAIN_SRC).tex | $(BUILD_DIR) $(PDF_DIR)
	latexmk -pdf -output-directory=$(BUILD_DIR) $(MAIN_SRC).tex
	mv $(BUILD_DIR)/$(MAIN_SRC).pdf $(PDF_DIR)/$(MAIN_PDF).pdf

define VARIANT_rule
$(PDF_DIR)/variants/$(VARIANT_PDF_$(1)).pdf: variants/$(1).tex | $$(BUILD_DIR) $$(PDF_DIR)
	latexmk -pdf -output-directory=$$(BUILD_DIR) $$<
	mv $$(BUILD_DIR)/$(1).pdf $$(@D)/$$(@F)
endef
$(foreach v,$(VARIANTS),$(eval $(call VARIANT_rule,$(v))))

define COVER_rule
$(PDF_DIR)/cover-letters/$(COVER_PDF_$(1)).pdf: cover-letters/$(1).tex | $$(BUILD_DIR) $$(PDF_DIR)
	latexmk -pdf -output-directory=$$(BUILD_DIR) $$<
	mv $$(BUILD_DIR)/$(1).pdf $$(@D)/$$(@F)
endef
$(foreach c,$(COVERS),$(eval $(call COVER_rule,$(c))))

clean:
	latexmk -C -output-directory=$(BUILD_DIR)
	rm -rf $(BUILD_DIR)/*

.PHONY: all clean
