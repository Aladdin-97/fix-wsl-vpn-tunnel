# fix-wsl-vpn-tunnel
# This script fixes /etc/resolv.conf to address an issue where DNS is not updated in WSL.
# Refer to https://github.com/Microsoft/WSL/issues/1350 for more information.
# If the 'ed' command is not found, install it manually. (Ex: 'sudo apt-get install ed')

# Instructions:
# 1. Connect to the VPN.
# 2. Run this script right admin rights from the WSL prompt.
# 3. Test nslookup from the WSL prompt if the script runs successfully.
