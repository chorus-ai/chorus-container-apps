#!/bin/bash
# NOTE: update GH secret to add user(s)
# Added users: 2025-03-28

declare -A array;
eval ${1}

for i in "${!array[@]}"; do
    username=$i;
    password=${array[$i]};
    adduser --gecos "" --disabled-password $username;
    chpasswd <<<"$username:$password";
done
