#! /bin/bash

# Directorio donde se guardará el respaldo
DIRECTORIO_DESTINO="/home/ubuntu/backups"
CONTENEDOR="s3://nombre_contenedor/carpeta/"
# Timestamp (para crear un nombre único de archivo)
TIMESTAMP=`/bin/date +%d-%m-%Y-%T`
# Crear el directorio de archivos si no existe
mkdir -p $DIRECTORIO_DESTINO

# Eliminar backups mayores a 14 días
find $DIRECTORIO_DESTINO -type f -name "*.gz" -mtime +14 -exec rm {} \;

# Base de datos elinge
DB_USUARIO="usuario_base_datos"
DB_URL="localhost o url"
DB_CLAVE="password"
DB_NOMBRE="nombre_base_datos"

# Backup MySQL base de datos
mysqldump -h$DB_URL -u$DB_USUARIO -p$DB_CLAVE --triggers --routines --no-tablespaces --events $DB_NOMBRE --set-gtid-purged=OFF > $DIRECTORIO_DESTINO/$DB_NOMBRE-$TIMESTAMP.sql

# Comprimir backup
gzip $DIRECTORIO_DESTINO/$DB_NOMBRE-$TIMESTAMP.sql

# Copiar en contenedor S3
# Debes tener instalado y configurado AWS Cli
/usr/local/bin/aws s3 cp $DIRECTORIO_DESTINO/$DB_NOMBRE-$TIMESTAMP.sql.gz $CONTENEDOR
echo "Backup $DB_NOMBRE completado"

# OPCIONAL
# Configura una URL tipo webhook para notificar al finalizar la ejecución del respaldo
WEBHOOK="https://gitbhub.com"
if curl --output /dev/null --silent --head --fail "$URLMAIL"; then
    echo '%s\n' "Webhook completado"
else
    echo '%s\n' "Webhook fallas"
fi
