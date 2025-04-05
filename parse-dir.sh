#!/data/data/com.termux/files/usr/bin/bash

# Usage: ./parse-dir.sh http://example.com/path/ > files.txt

URL="$1"

[[ -z "$URL" ]] && {
  echo "Usage: $0 <base_url>"
  exit 1
}

# Fetch and parse
curl -s "$URL" | pup 'a attr{href}' | while read -r LINK; do
  [[ "$LINK" == "../" || "$LINK" == "/" || "$LINK" == "#"* ]] && continue

  if [[ "$LINK" == */ ]]; then
    # Recurse into subdir
    ./parse-dir.sh "${URL}${LINK}"
  else
    echo "${URL}${LINK}"
  fi
done
