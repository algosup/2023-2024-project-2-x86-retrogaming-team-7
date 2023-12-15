#!/usr/bin/env bash
set -Cue

this_dir="$(cd "$( dirname "$0" )" && pwd)"
rootDir="$(cd "${this_dir}" && pwd)"
binDir="${rootDir}" 

echo "$binDir"

cd "${this_dir}" \
  && nasm mainmenu.asm -f bin -o "${binDir}/MENU.com"

ROOT_DIR=$(cd "${this_dir}" && pwd)
BIN_DIR="$ROOT_DIR"
DOSBOX_BIN="/opt/homebrew/bin/dosbox"
CONFIG_LOC="$ROOT_DIR"

# Uncomment the line below to include configuration file
# "$DOSBOX_BIN" -conf "$CONFIG_LOC"

"$DOSBOX_BIN" -c "MOUNT c $BIN_DIR" -c "C:" -c "keyb fr" -c "MENU.com"
