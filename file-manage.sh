#!/data/data/com.termux/files/usr/bin/bash

# Usage: ./file-manage.sh /sdcard/Downloads/target

DIR="$1"

[[ ! -d "$DIR" ]] && {
  echo "Usage: $0 <download_directory>"
  exit 1
}

cd "$DIR" || exit 1

# Example: Strip query strings, lowercase, remove spaces
for FILE in *\?*; do
  [[ -e "$FILE" ]] || continue
  CLEANED=$(echo "$FILE" | sed 's/\?.*//' | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
  [[ "$FILE" != "$CLEANED" ]] && mv -n "$FILE" "$CLEANED"
done

# Clean partials
find . -name '*.aria2' -type f -delete
