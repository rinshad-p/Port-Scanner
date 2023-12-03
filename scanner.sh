#!/bin/bash

echo -n "Enter The IP for Scanning: "
read ip

echo -n "Do you want to scan any specific ports? (Y/N): "
read specific_port

if [[ "$specific_port" == "y" || "$specific_port" == "Y" ]]; then
    echo -n "Enter Starting Port: "
    read startPort
    echo -n "Enter Ending Port: "
    read endPort
else
    startPort=1
    endPort=65535
fi

echo -e "Scanning $ip from port $startPort to $endPort\n"

function portscan {
    echo "Please wait while it is scanning all the open ports..."

    for ((port=startPort; port<=endPort; port++))
    do
        (echo > /dev/tcp/$ip/$port) > /dev/null 2>&1 && echo "Port $port is open" &
    done
    wait
}

portscan

echo "Scanning is Completed!"