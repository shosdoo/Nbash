#!/bin/bash

GREEN="\e[32;44m"
RESET="\e[0m"

echo -e "${GREEN}Ingresa la ip: ${RESET} \c"
read ip

echo -e "${GREEN}Realizando escaneo de puertos abiertos de la ip $ip ${RESET}"
open_ports=$(/usr/bin/nmap -p- --open -sS --min-rate 4000 -n -Pn -oG ports "$ip" 1>/dev/null && /usr/bin/cat ports | grep -ioP "\d+/open"| awk -F/ '{print $1}'|tr '\n' ','| sed -e 's/.$//' && rm ports)

echo -n -e "${GREEN}Puertos abiertos encontrados: $open_ports ${RESET}"

echo -e "\n\n${GREEN}Realizando escaneo de versiones...${RESET}"

nmap -sC -sV -p "$open_ports" -oN versiones.txt "$ip" 1>/dev/null
echo -e "\n${GREEN}Escaneo finalizado, resultados guardados en: versiones.txt${RESET}"
