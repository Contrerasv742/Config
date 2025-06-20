# Reduce file size and frame rate
for gif in ~/.config/fastfetch/imgs/*.gif; do
    filename=$(basename "$gif" .gif)
    # Reduce to every 3rd frame, resize, and optimize
    magick "$gif" -coalesce -delete 1-2 -resize 300x300 -layers optimize "${filename}_optimized.gif"
done

# Create slower, smaller GIFs
for gif in ~/.config/fastfetch/imgs/*.gif; do
    filename=$(basename "$gif" .gif)
    magick "$gif" -coalesce -resize 200x200 -delay 50 -layers optimize "${filename}_slow.gif"
done
