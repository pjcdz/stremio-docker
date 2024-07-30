#!/bin/sh

# Verifica si el script se está ejecutando como root
if [ "$(id -u)" -ne 0 ]; then
  echo "Este script debe ejecutarse como root" 1>&2
  exit 1
fi

# Limpiar reglas de iptables existentes
iptables -F
iptables -X

# Establecer política por defecto para denegar todo el tráfico entrante
iptables -P INPUT DROP

# Permitir tráfico entrante en el puerto 8080 solo desde la IP especificada
iptables -A INPUT -p tcp --dport 8080 -s 190.194.229.17 -j ACCEPT

# Permitir tráfico entrante en los puertos 11470 y 12470 para todas las IPs
iptables -A INPUT -p tcp --dport 11470 -j ACCEPT
iptables -A INPUT -p tcp --dport 12470 -j ACCEPT

# Permitir tráfico entrante relacionado y establecido
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Permitir tráfico local (necesario para funcionamiento interno del contenedor)
iptables -A INPUT -i lo -j ACCEPT

# Ejecutar el script original de inicio del servicio
exec "$@"
