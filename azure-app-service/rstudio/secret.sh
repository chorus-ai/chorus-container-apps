#!/bin/bash

declare -A array;
eval ${1}

for i in "${!array[@]}"; do
    username=$i;
    password=${array[$i]};
    adduser --gecos "" --disabled-password $username;
    chpasswd <<<"$username:$password";
done
