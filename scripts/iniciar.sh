#!/bin/bash

# Ir al directorio raíz del repositorio,
# independientemente de desde dónde se ejecute el script
cd "$(dirname "$0")/.." || exit 1

# Detectar Docker Compose v1 o v2
if command -v docker-compose &> /dev/null; then
    COMPOSE="docker-compose"
elif docker compose version &> /dev/null; then
    COMPOSE="docker compose"
else
    echo "Error: Docker Compose no encontrado."
    exit 1
fi

# Construir la imagen si hace falta
$COMPOSE build

# Iniciar contenedor
$COMPOSE up -d

# Abrir terminal dentro del contenedor
docker exec -it python-cientifico bash