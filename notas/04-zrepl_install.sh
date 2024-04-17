#!/usr/bin/env bash

#Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# variables
ZREPL_KEY_URL="https://zrepl.cschwarz.com/apt/apt-key.asc"
ZREPL_KEY_DEST="/usr/share/keyrings/zrepl.gpg"
ARCH="$(dpkg --print-architecture)"
CODENAME="$(lsb_release -i -s | tr '[:upper:]' '[:lower:]') $(lsb_release -c -s | tr '[:upper:]' '[:lower:]')"

trap ctrl_c INT
function ctrl_c(){
  echo -e "\n${ROJO}[ZFS]Programa Terminado ${FIN}"
  exit 0
}

echo -e "\n${AMARILLO}[ZREPL]Instalando dependencias ${FIN}"
sudo apt update && sudo apt install -y curl gnupg lsb-release

echo -e "\n${AMARILLO}[ZREPL]Importando las llaves ${FIN}"
curl -fsSL "$ZREPL_KEY_URL" | tee | gpg --dearmor | sudo tee "$ZREPL_KEY_DEST" > /dev/null

echo -e "\n${AMARILLO}[ZREPL]Agregando repos ${FIN}"
echo "deb [arch=$ARCH signed-by=$ZREPL_KEY_DEST] https://zrepl.cschwarz.com/apt/$CODENAME main" | sudo tee /etc/apt/sources.list.d/zrepl.list 

echo -e "\n${AMARILLO}[ZREPL]Instalando zrepl y holdeando segun recomendacion oficial ${FIN}"
sudo apt update && sudo apt install -y zrepl && sudo apt-mark hold zrepl
