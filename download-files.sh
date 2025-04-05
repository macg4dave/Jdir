#!/data/data/com.termux/files/usr/bin/bash

# Usage: ./download-files.sh files.txt /sdcard/Downloads/target

FILE_LIST="$1"
DEST="$2"

[[ ! -f "$FILE_LIST" || -z "$DEST" ]] && {
  echo "Usage: $0 <file_list> <destination_dir>"
  exit 1
}

mkdir -p "$DEST"

while read -r URL; do
  FILENAME=$(basename "$URL")
  OUTFILE="$DEST/$FILENAME"

  # Skip if already complete
  [[ -f "$OUTFILE" ]] && {
    echo "Skipping (exists): $FILENAME"
    continue
  }

  # Use aria2c with resume
  aria2c -x 8 -s 8 -c -d "$DEST" "$URL"
done < "$FILE_LIST"
