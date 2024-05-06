# MySQL dump into AWS S3 BUCKET
Respaldar una base de datos MySQL en un contenedor S3 de AWS, con línea de comandos Bash.

Este es un script realizado en Bash para ejecutarse en servidores Linux.

el archivo mysqldump.sh contiene la línea de comando escensiales para la descarga de base de datos y copia en S3:

1. Crear el directorio de destino
2. Configurar la conexión a base de datos
3. Ejecutar mysqldump
4. Comprimir .sql
5. Copiar en contenedor S3 

# Configuración

1. Instalar aws cli. Ver instrucciones en https://docs.aws.amazon.com/cli/latest/userguide/installing.html
2. Ejecutar `aws configure` para configurar los datos de conexión al contenedor S3.
3. Almacenar el fichero mysqldump.sh en una carpeta de su servidor. (Ejemplo: /opt/scripts).
4. Asignar permisos de ejecución: `chmod +x /opt/scripts/mysqldump.sh`.
5. Editar las variables DIRECTORIO_DESTINO, DB_USUARIO, DB_URL, DB_CLAVE, DB_NOMBRE.
6. Probar el script escribiendo en línea de comandos `/opt/scripts/mysqldump.sh`.

# Configurar tarea repetitiva

1. Ingresar y editar cron: `crontab -e`.
2. Agregar la final la siguiente línea. Para éste ejemplo se ejecuta a las 21 horas con 30 minutos, todos los martes.

 `30 21 * * 2 /opt/scripts/mysqldump.sh`  

3. `crontab -l` para revisar si quedó almacenada y list.

Ya tienes tu sistema listo pra realizar respaldos.