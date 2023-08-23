#!/usr/bin/env bash

# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
FIN="\033[0m\e[0m"

#CTRL-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${ROJO}[ZFS_USERS]Programa Terminado ${FIN}"
        exit 0
}

#Variables
USUARIOS=(usu1 usu2 usu3)
GRUPO=nombre_grupo

echo -e "${VERDE}[ZFS_USERS]Agregando grupo $GRUPO ${FIN}"
sudo groupadd "$GRUPO" && for i in "${USUARIOS[@]}"; do sudo adduser --no-create-home "$i" --force-badname && sudo adduser "$i" "$GRUPO"; done

echo -e "${VERDE}[ZFS_USERS]Todos los usuarios han sido creados ${FIN}"
