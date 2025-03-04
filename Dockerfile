# Usar la imagen oficial de NGINX como base
FROM nginx:latest

# Copiar los archivos de la página web al directorio de NGINX
COPY . /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Comando por defecto para iniciar NGINX
CMD ["nginx", "-g", "daemon off;"]