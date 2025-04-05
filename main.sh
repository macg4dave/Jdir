#!/data/data/com.termux/files/usr/bin/bash

# Default config file path
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
CONFIG_FILE="$SCRIPT_DIR/.config.env"

# Parse CLI args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --url)
      BASE_URL="$2"
      shift 2
      ;;
    --saveloc)
      DEST_DIR="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

[[ -z "$BASE_URL" || -z "$DEST_DIR" ]] && {
  echo "Usage: $0 --url <url> --saveloc <destination_folder>"
  exit 1
}

# Create config file
cat > "$CONFIG_FILE" <<EOF
BASE_URL="$BASE_URL"
DEST_DIR="$DEST_DIR"
SCRIPT_DIR="$SCRIPT_DIR"
URL_LIST="\$SCRIPT_DIR/files.txt"
MAX_CONNECTIONS=8
SPLIT=8
EOF

# Run the tools
bash "$SCRIPT_DIR/parse-dir.sh"
bash "$SCRIPT_DIR/download-files.sh"
bash "$SCRIPT_DIR/file-manage.sh"
