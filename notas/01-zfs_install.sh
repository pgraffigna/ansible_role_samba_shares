#!/usr/bin/env bash

#Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
  echo -e "\n${ROJO}[ZFS]Programa Terminado ${FIN}"
  exit 0
}

echo -e "\n${AMARILLO}[ZFS] Instalando ZFS ${FIN}"
if ! [ "$(command -v zfsutils-linux)" ]; then
  sudo apt update && sudo apt install -y zfsutils-linux
else
  echo "El programa ya esta instalado..continuando"
fi

echo -e "\n${AMARILLO}[ZFS]Listando los discos disponibles ${FIN}"
lsblk -f

echo -e "\n${AMARILLO}[ZFS]Creación del RAIDz ${FIN}"
read -p "Ingresa el nombre del POOL: " POOL

read -p "Ingresa el nombre de los discos separados por espacio:
 >> " -ra DISCOS
sudo zpool create -f "$POOL" "/dev/${DISCOS[@]}"

echo -e "\n${AMARILLO}[ZFS]Chequeando el estado del POOL ${FIN}"
zpool status

echo -e "\n${VERDE}[ZFS]Todos los procesos terminaron correctamente!!! ${FIN}"
