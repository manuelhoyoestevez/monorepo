#!/bin/sh

DIRS="
crud-codegen
crud-core
crud-spring5
key-tools
key-tools-bc-jdk15on-generator
request-core
request-spring5
openapi-invoker-core
openapi-invoker-builder
openapi-invoker-oauth-scribejava
openapi-invoker-example
openapi-firewall-core
openapi-firewall-io-swagger
sheet-lib
"

if [ "$#" -eq 0 ]; then
  set -- git pull
fi

for dir in $DIRS; do
  echo "===================================="
  echo "Entrando en: $dir"
  echo "Ejecutando: $*"
  echo "===================================="

  if [ -d "$dir" ]; then
    (
      cd "$dir" || exit 1
      "$@"
    )
  else
    echo "Directorio no encontrado: $dir"
  fi

  echo
done
