# Usa la imagen base preconstruida
FROM tsaridas/stremio-docker:latest

# Instala iptables
RUN apk add --no-cache iptables

# Copia el script de iptables
COPY iptables.sh /iptables.sh
RUN chmod +x /iptables.sh

# Ejecuta el script de iptables antes de iniciar el servicio
ENTRYPOINT ["/iptables.sh"]

# Ejecuta el script original de inicio del servicio
CMD ["./stremio-web-service-run.sh"]
