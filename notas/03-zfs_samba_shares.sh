#!/usr/bin/env bash

# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# CTRL-C
trap ctrl_c INT
function ctrl_c(){
  echo -e "\n${ROJO}[ZFS_SHARES]Programa Terminado ${FIN}"
  exit 0
}

# Variables
USUARIOS=(usu1 usu2 usu3)
GRUPO=nombre_grupo
COMPARTIDAS=(drivers imagenes backups programas)
POOL=$(zpool status | grep 'pool:' | awk '{printf $2}')

echo -e "${AMARILLO}[ZFS_SHARES]Instalando el servicio samba ${FIN}"
sudo apt update && sudo apt install -y samba

echo -e "${AMARILLO}[ZFS_SHARES]Credenciales samba $FIN"
for i in "${USUARIOS[@]}"; do echo -e "para $i\n" && sudo smbpasswd -a "$i" ; done

echo -e "${AMARILLO}[ZFS_SHARES]Creacion de Compartidas ${FIN}"
for i in "${COMPARTIDAS[@]}"; do sudo zfs create "$POOL"/"$i" ; done

echo -e "${AMARILLO}[ZFS_SHARES]Cambiar permisos de acceso a las Compartidas ${FIN}"
for i in "${COMPARTIDAS[@]}"; do sudo chown -R pgraffigna:"$GRUPO" /"$POOL"/"$i" ; done

echo -e "${AMARILLO}[ZFS_SHARES]Cambiar permisos de las Compartidas ${FIN}"
for i in "${COMPARTIDAS[@]}"; do sudo chmod 755 -R /"$POOL"/"$i" ; done

echo -e "${AMARILLO}[ZFS_SHARES]Activar acceso via SMB a las compartidas ${FIN}"
for i in "${COMPARTIDAS[@]}"; do sudo zfs set sharesmb=on "$POOL"/"$i" ; done

echo -e "${AMARILLO}[ZFS_SHARES]Reiniciar el servicio y mostrar el estado ${FIN}"
sudo systemctl restart smbd.service && sudo systemctl status smbd.service

echo -e "${VERDE}[ZFS_SHARES]Todos los procesos terminaron correctamente!!!  ${FIN}"




