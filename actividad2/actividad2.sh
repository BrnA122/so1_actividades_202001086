#!/bin/bash

# Definir variable GITHUB_USER
GITHUB_USER="BrnA122"

# Consultar URL 
URL_API="https://api.github.com/users/${GITHUB_USER}"
RESPONSE=$(curl -s $URL_API)

# Validar si la respuesta es un objeto JSON
if [ -z "$RESPONSE" ]; then
  # Si la respuesta no es un objeto JSON, imprimir un mensaje de error
  echo "La respuesta no es un objeto JSON"
  # Salir del script con código 1
  exit 1
fi

# Validar Usuario
USER_ID=$(echo $RESPONSE | jq -r '.id')

if [ "$USER_ID" == "null" ]; then
  # Si la respuesta no es un objeto JSON, imprimir un mensaje de error
  echo "El usuario ${GITHUB_USER} no existe"
  # Salir del script con código 1
  exit 1
fi

# Extraer Información
USER_NAME=$(echo $RESPONSE | jq -r '.name')
USER_CREATE=$(echo $RESPONSE | jq -r '.created_at')

# Imprimir Información
MSG="Hola ${USER_NAME}. User ID: ${USER_ID}. Cuenta creada el ${USER_CREATE}"
echo $MSG

# Crear directorio y archivo de log
# Obtener la fecha actual en formato YYYY-MM-DD
FECHA=$(date +%Y-%m-%d)

# Crear el directorio /tmp/<fecha> si no existe
DIRECTORIO="/tmp/${FECHA}"
mkdir -p $DIRECTORIO

# Crear el archivo de log
LOG_FILE="${DIRECTORIO}/saludos.log"

# Escribir el mensaje en el archivo de log
echo $MSG >> $LOG_FILE

# Añadir un cron job para ejecutar el script cada 5 minutos
# Obtener el crontab actual
(crontab -l 2>/dev/null; echo "*/5 * * * * /bin/bash $(realpath $0)") | crontab -