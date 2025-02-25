#!/bin/bash

# Definir el directorio del proyecto
dIRECTORIO_PROYECTO="/var/www/html"

# Apagar NGINX y NGROK
sudo systemctl stop nginx
pkill -f ngrok

echo "NGINX y NGROK han sido detenidos."

# Navegar al directorio del proyecto
cd "$dIRECTORIO_PROYECTO" || exit

# Verificar si el repositorio está clonado
if [ ! -d ".git" ]; then
    echo "El repositorio no está clonado. Clonando ahora..."
    git clone https://github.com/FernandoVS11/PaginaWebEC2.git .
else
    echo "Repositorio encontrado. Actualizando..."
    git pull origin main
fi

echo "Repositorio actualizado con éxito."

# Encender NGINX
sudo systemctl start nginx
echo "NGINX ha sido iniciado."

# Iniciar NGROK y obtener la URL
ngrok http 80 > /dev/null &
sleep 5 # Esperar a que NGROK genere la URL
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

echo "NGROK está en ejecución. La URL pública es: $NGROK_URL"

# Desplegar la URL de NGROK (por ejemplo, en un archivo o terminal)
echo "URL de NGROK: $NGROK_URL" | tee ngrok_url.txt


echo "NGROK está en ejecución. La URL pública es: $NGROK_URL"

# Desplegar la URL de NGROK (por ejemplo, en un archivo o terminal)
echo "URL de NGROK: $NGROK_URL" | tee ngrok_url.txt
