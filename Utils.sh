#!/data/data/com.termux/files/usr/bin/bash
CONFIG="$(dirname "$0")/../etc/config.json"

validate_url() {
  [[ "$1" =~ ^https?:// ]] || die "Invalid URL: $1"
}

validate_dir() {
  [ -w "$1" ] || die "Directory not writable: $1"
}

die() {
  echo "ERROR: $*" >&2
  exit 1
}
