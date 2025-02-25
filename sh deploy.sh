#!/bin/bash

DIRECTORIO_PROYECTO="/var/www/html"

sudo systemctl stop nginx
pkill -f ngrok

echo "NGINX y NGROK han sido detenidos."

cd "$DIRECTORIO_PROYECTO" || exit

if [ ! -d ".git" ]; then
    echo "El repositorio no está clonado. Clonando ahora..."
    git clone https://github.com/FernandoVS11/PaginaWebEC2.git .
else
    echo "Repositorio encontrado. Actualizando..."
    git pull origin main
fi

echo "Repositorio actualizado con éxito."

sudo systemctl start nginx
echo "NGINX ha sido iniciado."

ngrok http 80 > /dev/null &
sleep 5 # Esperar a que NGROK genere la URL
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

echo "NGROK está en ejecución. La URL pública es: $NGROK_URL"


