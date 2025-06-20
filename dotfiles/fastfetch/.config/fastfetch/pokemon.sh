#!/bin/bash

# Directory with Pokémon images
POKEMON_DIR="$HOME/.config/fastfetch/imgs"

# Get a list of all image files in the directory
IMAGE_FILES=($POKEMON_DIR/*)

# Check if there are any image files
if [ ${#IMAGE_FILES[@]} -eq 0 ]; then
    echo "No image files found in $POKEMON_DIR"
    exit 1
fi

# Choose a random image from the array
RANDOM_POKEMON=${IMAGE_FILES[$RANDOM % ${#IMAGE_FILES[@]}]}

# Print which Pokémon was selected (optional)
echo "Selected Pokémon: $(basename "$RANDOM_POKEMON")"

# Run fastfetch with the random Pokémon
CONFIG="$HOME/.config/fastfetch/arch.jsonc"
fastfetch --config "$CONFIG" --kitty-icat "$RANDOM_POKEMON" --logo-width 25 --logo-height 25
