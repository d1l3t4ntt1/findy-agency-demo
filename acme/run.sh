#!/bin/bash

set -e

current_dir=$(dirname "$BASH_SOURCE")

source "$current_dir/../login.sh"

user="Acme"

login $user
