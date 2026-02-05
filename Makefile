# Makefile for generating STL files from OpenSCAD sources
# Usage: make [target]

OPENSCAD := openscad
SCAD_DIR := Printed-Parts/SCAD
STL_DIR := Printed-Parts/STL

# Library files (not exported to STL)
LIBRARIES := bearing.scad polyholes.scad

# All SCAD files
ALL_SCAD := $(wildcard $(SCAD_DIR)/*.scad)

# Filter out library files
PART_SCAD := $(filter-out $(addprefix $(SCAD_DIR)/,$(LIBRARIES)),$(ALL_SCAD))

# Generate STL paths from SCAD files
# Special case: Heatbed-cable-clip_8mm.scad -> Heatbed-cable-clip_for_8mm_sleeve.stl
STL_FILES := $(patsubst $(SCAD_DIR)/%.scad,$(STL_DIR)/%.stl,$(PART_SCAD))
STL_FILES := $(subst Heatbed-cable-clip_8mm.stl,Heatbed-cable-clip_for_8mm_sleeve.stl,$(STL_FILES))

.PHONY: all clean help list

all: $(STL_FILES)
	@echo ""
	@echo "Build complete: $(words $(STL_FILES)) STL files generated"

# Generic rule for SCAD -> STL conversion
$(STL_DIR)/%.stl: $(SCAD_DIR)/%.scad
	@echo "Building $@..."
	@$(OPENSCAD) -o $@ $<

# Special case for renamed file
$(STL_DIR)/Heatbed-cable-clip_for_8mm_sleeve.stl: $(SCAD_DIR)/Heatbed-cable-clip_8mm.scad
	@echo "Building $@..."
	@$(OPENSCAD) -o $@ $<

clean:
	@echo "Cleaning generated STL files..."
	@rm -f $(STL_FILES)
	@echo "Done"

help:
	@echo "OpenSCAD STL Generator"
	@echo ""
	@echo "Usage:"
	@echo "  make          - Build all STL files"
	@echo "  make clean    - Remove generated STL files"
	@echo "  make list     - List all STL targets"
	@echo "  make help     - Show this help message"
	@echo ""
	@echo "Build specific files:"
	@echo "  make $(STL_DIR)/x-carriage.stl"
	@echo ""
	@echo "Prerequisites:"
	@echo "  - OpenSCAD must be installed and in PATH"

list:
	@echo "STL targets ($(words $(STL_FILES)) files):"
	@echo ""
	@for f in $(STL_FILES); do echo "  $$f"; done
