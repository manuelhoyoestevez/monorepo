#!/usr/bin/env bash

set -u

JSON_FILE="${1:-base.json}"

if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq no está instalado."
    exit 1
fi

if ! command -v git >/dev/null 2>&1; then
    echo "Error: git no está instalado."
    exit 1
fi

if [ ! -f "$JSON_FILE" ]; then
    echo "Error: no existe el fichero $JSON_FILE"
    exit 1
fi

if [ ! -d .git ]; then
    echo "Error: la carpeta actual no es un repositorio git."
    exit 1
fi

jq -c '.[]' "$JSON_FILE" | while read -r repo; do
    name=$(echo "$repo" | jq -r '.name')
    url=$(echo "$repo" | jq -r '.url')
    branch=$(echo "$repo" | jq -r '.branch')

    echo "Procesando: $name"

    if [ -e "$name" ]; then
        echo "  Ya existe. Se omite."
        continue
    fi

    if git submodule add -b "$branch" "$url" "$name"; then
        echo "  OK"
    else
        echo "  ERROR al añadir $name"
    fi

    echo
done
