#!/bin/bash

# This script fixes /etc/resolv.conf to address an issue where DNS is not updated in WSL.
# Refer to https://github.com/Microsoft/WSL/issues/1350 for more information.
# If the 'ed' command is not found, install it manually. (Ex: 'sudo apt-get install ed')

# Instructions:
# 1. Connect to the VPN.
# 2. Run this script right admin rights from the WSL prompt.
# 3. Test nslookup from the WSL prompt if the script runs successfully.

echo "Modifying namesever for VPN"
vpn() {
[ -s /run/resolvconf/resolv.conf -a -L /etc/resolv.conf ] && sudo cp --remove-destination /run/resolvconf/resolv.conf /etc/resolv.conf
local sudo="sudo"
if [ -w /etc/resolv.conf ]; then sudo=""; fi
$sudo ed -s /etc/resolv.conf <<'EOF'
H
a
#EOF
.
kx
g/^nameserver /d
.-1r !/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command '$x = Get-NetAdapter | Group-Object -AsHashtable -Property ifIndex; Get-DnsClientServerAddress -AddressFamily ipv4 | where {$x[$_.InterfaceIndex].Status -eq "Up"} | Select-Object -ExpandProperty ServerAddresses | foreach {"nameserver " + $_}' | sed 's/\r//g'
'xd
wq
EOF
}
vpn
echo "Done!"
sleep 5
