#!/usr/bin/env bash

set -euo pipefail

JSON_FILE="${1:-base.json}"

if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq no está instalado."
    echo "Instálalo con: sudo apt install jq"
    exit 1
fi

if [ ! -f "$JSON_FILE" ]; then
    echo "Error: no existe el fichero $JSON_FILE"
    exit 1
fi

echo "<modules>"
jq -r '.[].name' "$JSON_FILE" | while read -r name; do
    echo "    <module>$name</module>"
done
echo "</modules>"
