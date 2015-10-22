#!/bin/bash

printf "nameserver 208.67.222.222\nnameserver 208.67.220.220\n" > /etc/resolv.conf

if [[ "$RESTORE" == "true" ]]; then
  ./restore.sh
else
  ./backup.sh
fi
