#!/bin/bash
# Generate STL files from SCAD sources

SCAD_DIR="$(dirname "$0")/SCAD"
STL_DIR="$(dirname "$0")/STL"

SKIP_FILES=("bearing.scad" "polyholes.scad")

declare -A NAME_MAP
NAME_MAP["Heatbed-cable-clip_8mm"]="Heatbed-cable-clip_for_8mm_sleeve"

is_skip_file() {
    local file="$1"
    for skip in "${SKIP_FILES[@]}"; do
        if [ "$file" == "$skip" ]; then
            return 0
        fi
    done
    return 1
}

generate_stl() {
    local scad_file="$1"
    local base_name="${scad_file%.scad}"
    if [ -n "${NAME_MAP[$base_name]}" ]; then
        local stl_name="${NAME_MAP[$base_name]}.stl"
    else
        local stl_name="${base_name}.stl"
    fi
    echo "Generating: $scad_file -> $stl_name"
    openscad -o "$STL_DIR/$stl_name" "$SCAD_DIR/$scad_file"
    if [ $? -eq 0 ]; then
        echo "  Success"
    else
        echo "  Failed"
        return 1
    fi
}

cd "$(dirname "$0")"

if [ -n "$1" ]; then
    scad_file="$(basename "$1")"
    if [ ! -f "$SCAD_DIR/$scad_file" ]; then
        echo "Error: $scad_file not found in $SCAD_DIR"
        exit 1
    fi
    generate_stl "$scad_file"
else
    echo "Generating STL files from SCAD sources..."
    echo "SCAD directory: $SCAD_DIR"
    echo "STL directory: $STL_DIR"
    echo ""
    failed=0
    success=0
    skipped=0
    for scad_path in "$SCAD_DIR"/*.scad; do
        scad_file="$(basename "$scad_path")"
        if is_skip_file "$scad_file"; then
            echo "Skipping library: $scad_file"
            ((skipped++))
            continue
        fi
        if generate_stl "$scad_file"; then
            ((success++))
        else
            ((failed++))
        fi
    done
    echo ""
    echo "Summary: $success succeeded, $failed failed, $skipped skipped"
fi
