#!/bin/bash

set -e

current_dir=$(dirname "$BASH_SOURCE")

source "$current_dir/../login.sh"

user="Faber"

login $user "$current_dir/bot.yaml" "true"

conn_id=$(echo $(uuidgen) | tr '[:upper:]' '[:lower:]')
echo "Creating invitation with connection id $conn_id"
invitation=$(findy-agent-cli agent invitation --label $user -u --conn-id=$conn_id)

printf "\n\nHi there Alice 👋 \n"
printf "\nCongratulations on your graduation 🎉 \n"
printf "\nPlease read the QR code with your wallet application to receive your degree credential.\n\n"

qrencode -m 0 -t utf8i <<< $invitation

printf "\n$invitation\n"

printf "\nFaber bot started 🤖\n"
findy-agent-cli bot start --conn-id $conn_id $current_dir/bot.yaml


