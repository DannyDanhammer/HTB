#!/bin/bash

#Function to open new terminal - add to requirments doc sudo apt install gnome-terminal
function newterm() {
    gnome-terminal -- bash -c "$1; exec bash"
}

# function to validate the ip address
# copied from:  https://www.linuxjournal.com/content/validating-ip-address-bash-script
function valid_ip() {
    local ip=$1
    local stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 &&
            ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?

        # verify that we received only one argument:
        if [ $# -gt 1 ]; then
            echo "Failed validation, additional data supplied."
            stat=1
        fi
    fi
    return $stat
}

# Function to create directories if they do not exist
create_directory() {
    mkdir -p "$1"
    echo "Directory '$1' created."
}

######MAIN#######
###hardcoded file! set as a variable and add to setup/requirements script


if [ ! -f "bitquark-subdomains-top100000.txt" ]; then
  wget https://raw.githubusercontent.com/ds25041974/SecLists/master/Discovery/DNS/bitquark-subdomains-top100000.txt
fi

# Get the ovpn file from the user
echo "Enter the path to your .ovpn file: "
read OVPN_FILE
if [ ! -f "$OVPN_FILE" ]; then
  echo "$OVPN_FILE not found!"
fi
newterm 'echo "Logging in with $OVPN_FILE";sudo openvpn $OVPN_FILE'

# Prompt user for input
read -p "Enter the IP address: " ip_address
read -p "Enter the hostname: " hostname

# Call the function to create a directory named "HTB" on the user's Desktop
create_directory "$HOME/Desktop/HTB"

# Call the function to create a directory named after the $HOST variable inside the "HTB" directory
create_directory "$HOME/Desktop/HTB/$hostname"

#Sleep to allow connection
sleep 5

# validate IP Address
if ! valid_ip $ip_address; then
    echo "Invalid IP Address defined"
    exit 0
fi

# Set environmental variable
export TARGET="$ip_address"

# Construct the command to update /etc/hosts
update_hosts_command="echo \"$ip_address $hostname\" | sudo tee -a /etc/hosts"

# Execute the command to update /etc/hosts
eval "$update_hosts_command"

port_list=$(nmap -p- -T5 $TARGET | awk '{print $1}' | awk -F'/' '{print $1}' | grep -o '[0-9]*' | paste -sd "," -)

# Construct the nmap command
nmap_command="sudo  nmap -A -p $port_list -sC -sV -O -T5 $TARGET -oN $HOME/Desktop/HTB/$hostname/nmap_tcp_all.nmap"

# Execute the nmap command
eval "$nmap_command"

eval "wfuzz -w bitquark-subdomains-top100000.txt  -u http://$hostname/ -H 'Host:FUZZ.$hostname' -t 50 --hc 302"
##chmod +x htbstart
# note: maybe try adding openvpn start to the script as wellbut must include time delay of 40 seconds. Ideas Adam? I know you better be reading this super vulnerable code....I mean look at me running unvalidated eval !
