#!/usr/bin/env bash
set -euo pipefail

show_help() {
  cat << 'EOF'
Usage: batch_resize_images.sh -s <source> -t <size> [-o <output-dir>] [-q <quality>]
Options:
  -s, --source   Source directory containing images
  -t, --size     Resize target: WIDTH or WIDTHxHEIGHT (e.g., 1024 or 1024x768)
  -o, --output   Output directory (default: <source>/reduced)
  -q, --quality  JPEG quality (default: 85)
  -h, --help     Show this help
Notes:
  - Images are resized with -resize "WxH" to preserve aspect ratio.
  - Only downscaling occurs (no upscaling beyond original size).
  - The script writes reduced copies to the output dir; originals remain untouched.
EOF
}

SRC=""
SIZE=""
OUT=""
QUALITY=85

while [[ $# -gt 0 ]]; do
  case "$1" in
    -s|--source) SRC="$2"; shift 2;;
    -t|--size) SIZE="$2"; shift 2;;
    -o|--output) OUT="$2"; shift 2;;
    -q|--quality) QUALITY="$2"; shift 2;;
    -h|--help) show_help; exit 0;;
    *) echo "Unknown option: $1"; show_help; exit 1;;
  esac
done

if [[ -z "${SRC:-}" || -z "${SIZE:-}" ]]; then
  echo "Error: source and size are required." >&2
  show_help
  exit 1
fi

SRC="${SRC%/}"
OUT="${OUT:-$SRC/reduced}"

# Detect ImageMagick command
if command -v magick >/dev/null 2>&1; then
  IMG_CMD="magick"
elif command -v convert >/dev/null 2>&1; then
  IMG_CMD="convert"
else
  echo "ImageMagick not found. Install ImageMagick (convert/magick)." >&2
  exit 1
fi

# Build resize argument
RESIZE=""
if [[ "$SIZE" =~ ^([0-9]+)x([0-9]+)$ ]]; then
  W="${BASH_REMATCH[1]}"
  H="${BASH_REMATCH[2]}"
  RESIZE="${W}x${H}>"
elif [[ "$SIZE" =~ ^([0-9]+)$ ]]; then
  W="${BASH_REMATCH[1]}"
  RESIZE="${W}x>"
else
  echo "Invalid size: $SIZE. Use WIDTH or WIDTHxHEIGHT." >&2
  exit 1
fi

mkdir -p "$OUT"

shopt -s nullglob
for f in "$SRC"/*.{jpg,JPG,jpeg,JPEG,png,PNG,gif,GIF}; do
  [ -e "$f" ] || continue
  base=$(basename "$f")
  out="$OUT/$base"
  "$IMG_CMD" "$f" -auto-orient -resize "$RESIZE" -strip -quality "$QUALITY" "$out"
done

echo "Done. Reduced images saved to: $OUT"
