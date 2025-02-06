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
  echo "El programa ya esta instalado..continuamos"
fi

echo -e "\n${AMARILLO}[ZFS]Listando los discos disponibles ${FIN}"
lsblk -f

echo -e "\n${AMARILLO}[ZFS]Creando el nuevo POOL (RAIDZ) ${FIN}"
read -p "Ingresa el nombre para el nuevo POOL: " POOL

read -p "Ingresa el nombre de los discos [ej: vda vdb]
 >> " -ra DISCOS
sudo zpool create -f "$POOL" "/dev/${DISCOS[@]}"

# agregando compresion, recordsize al pool
echo -e "\n${AMARILLO}[ZFS]Configurando compression, recordsize y cache para el POOL "$POOL"...${FIN}"
sudo zfs set compression=on "$POOL"
sudo zfs set recordsize=1M "$POOL"

# configurando caching para el pool
sudo mkdir /zfs_cache
sudo dd if=/dev/zero of=/zfs_cache/write bs=1M count=1024 2>/dev/null # en el este ejemplo configuro 1GB para cache de escritura
sudo dd if=/dev/zero of=/zfs_cache/read bs=1M count=2048 2>/dev/null # en el este ejemplo configuro 2GB para cache de lectura

# aplicando caching al pool
sudo zpool add "$POOL" log /zfs_cache/write
sudo zpool add "$POOL" cache /zfs_cache/read

echo -e "\n${AMARILLO}[ZFS]Chequeando el estado del POOL: "$POOL" ${FIN}"
zpool status
echo "----------------------"
zfs get compression "$POOL"
echo "----------------------"
zfs get recordsize "$POOL"
