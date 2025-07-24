# creamos un scrip SH para deplgear el sitio web
# este script se encargará de compilar el sitio web y subirlo a la carpeta de producción
# además de eliminar los archivos innecesarios
# y de crear un archivo de registro con la fecha de despliegue
#!/bin/bash
# Variables
SOURCE_DIR="/home/lordvalor/Proyectos/log.vlozada.com/"
BUILD_DIR="/home/lordvalor/Proyectos/log.vlozada.com/_site"
DEPLOY_DIR="/var/www/log.vlozada.com"
LOG_FILE="/var/log/deploy.log"
# Función para registrar mensajes
log_message() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}
# Comenzamos el despliegue
log_message "Iniciando despliegue del sitio web"
# Navegamos al directorio del proyecto
cd "$SOURCE_DIR" || { log_message "Error: No se pudo acceder al directorio del proyecto"; exit 1; }
log_message "Compilando el sitio web"
# Compilamos el sitio web
npm run build || { log_message "Error: Falló la compilación del sitio web"; exit 1; }
log_message "Compilación exitosa"
# Limpiamos el directorio de producción
log_message "Limpiando el directorio de producción"
rm -rf "$DEPLOY_DIR"/* || { log_message "Error: Falló al limpiar el directorio de producción"; exit 1; }
# Copiamos los archivos compilados al directorio de producción
log_message "Copiando archivos al directorio de producción"
cp -r "$BUILD_DIR"/* "$DEPLOY_DIR"/ || { log_message "Error: Falló al copiar los archivos al directorio de producción"; exit 1; }
log_message "Archivos copiados exitosamente"
# Eliminamos archivos innecesarios
log_message "Eliminando archivos innecesarios"
find "$DEPLOY_DIR" -type f \( -name "*.map" -o -name "*.txt" -o -name "*.md" \) -exec rm -f {} \;
log_message "Archivos innecesarios eliminados"
# Creamos un archivo de registro con la fecha de despliegue
DEPLOY_DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo "Despliegue realizado el: $DEPLOY_DATE" > "$DEPLOY_DIR/deploy.log"
log_message "Despliegue completado exitosamente"
# Finalizamos el script
exit 0
# Fin del script de despliegue