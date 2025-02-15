#!/usr/bin/env bash

set -euo pipefail

# cd to the directory of this script
cd "$(dirname "$0")"

CONFIG_FILES="config.jsonc style.css"

while true; do
    systemctl --user restart waybar.service || true
    # killall -SIGUSR2 waybar
    echo "Reloaded Waybar"
    # shellcheck disable=SC2086
    inotifywait -e create,modify $CONFIG_FILES
done
