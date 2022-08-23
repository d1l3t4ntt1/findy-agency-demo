#!/bin/bash

set -e

current_dir=$(dirname "$BASH_SOURCE")

source "$current_dir/../login.sh"

user="acme@example.com"

login $user "$current_dir/bot.yaml"

conn_id=$(echo $(uuidgen) | tr '[:upper:]' '[:lower:]')
invitation=$(findy-agent-cli agent invitation --label "Acme" -u --conn-id=$conn_id)

printf "\n\nHi Alice 👋 \n"
printf "\nPlease read the QR code with your wallet application to prove your degree credential.\n\n"

qrencode -m 2 -t utf8i <<< $invitation

printf "\n$invitation\n"

printf "\nAcme bot started 🤖\n"
findy-agent-cli bot start --conn-id $conn_id $current_dir/bot.yaml


