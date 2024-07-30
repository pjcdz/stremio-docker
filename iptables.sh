#!/bin/sh

# Permitir el tráfico entrante en el puerto 8080 solo desde la IP especificada
iptables -A INPUT -p tcp --dport 8080 -s 190.194.229.17 -j ACCEPT
# Denegar todo el tráfico entrante en el puerto 8080 desde otras IPs
iptables -A INPUT -p tcp --dport 8080 -j DROP

# Ejecutar el script original de inicio del servicio
exec "$@"
