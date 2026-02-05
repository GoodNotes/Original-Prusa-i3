# Ink Robot - Modified Prusa i3 MK3S Models

> **Note:** This repository contains modified models for the ink robot project.

## Prerequisites

**OpenSCAD** is required to generate STL files from the SCAD source files.

**macOS:**
```bash
# Recommended: development snapshot (much faster than stable release)
brew install --cask openscad@snapshot

# Alternative: stable release
brew install --cask openscad
```
See: https://formulae.brew.sh/cask/openscad@snapshot

**Linux (Debian/Ubuntu):**
```bash
sudo apt install openscad
```

**Windows:**
Download from https://openscad.org/downloads.html

## Building STL Files

After modifying SCAD files, regenerate the STL files using one of these methods:

### Using Make (Recommended)

```bash
# Build all STL files
make

# Build a specific STL file
make Printed-Parts/STL/x-carriage.stl

# Clean generated files
make clean

# List available targets
make help
```

### Using the Shell Script

```bash
cd Printed-Parts

# Build all STL files
./generate-stls.sh

# Build a specific file
./generate-stls.sh x-carriage.scad
```

### Manual Generation

Open the SCAD file in OpenSCAD and use **File > Export > Export as STL**.

---

# Original Prusa i3 MK3S


Original Prusa i3 MK3S is a 3D printer project maintained by PRUSA RESEARCH.
Originates in [RepRap](https://reprap.org) project made possible by Dr. Adrian Bowyer and contributors.

This repository contains SCAD files and STLs of the printed parts.

**Links**

 * Prusa Research website : http://prusa3d.com
 * Product page: https://shop.prusa3d.com/en/3d-printers/180-original-prusa-i3-mk3-kit.html
 * Build manual: http://manual.prusa3d.com/c/Original_Prusa_i3_MK3_kit_assembly
 * Firmware : https://github.com/prusa3d/Prusa-Firmware
 * MK52 heatbed : https://github.com/prusa3d/Heatbed_MK52_magnetic
 * MK3 Power panic : https://github.com/prusa3d/MK3_Power_Panic
 * MK3S IR senzor : https://github.com/prusa3d/MKxS-IR-sensor
 
