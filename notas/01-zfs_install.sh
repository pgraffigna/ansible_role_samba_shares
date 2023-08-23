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

echo -e "\n${AMARILLO}[ZFS]Instalando los requisitos para usar ZFS ${FIN}"
sudo apt update && sudo apt install -y zfsutils-linux

echo -e "\n${AMARILLO}[ZFS]Listando los discos disponibles para crear el RAID ${FIN}"
lsblk -f

echo -e "\n${AMARILLO}[ZFS]Creación del RAIDZ${FIN}"
read -p "Ingresa el nombre del POOL: " POOL

read -p "[ZFS]Ingresa el nombre de los discos separados por espacio ej:
 >> " -ra DISCOS
sudo zpool create -f "$POOL" "/dev/${DISCOS[@]}"

echo -e "\n${AMARILLO}[ZFS]Chequeando el estado del POOL ${FIN}"
zpool status

echo -e "\n${VERDE}[ZFS]Todos los procesos terminaron correctamente!!! ${FIN}"
