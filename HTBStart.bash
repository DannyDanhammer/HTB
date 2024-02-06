#!/bin/bash


#Function to open new terminal - add to requirments doc sudo apt install gnome-terminal
function newterm() 
{
    gnome-terminal -- bash -c "$1; exec bash"
}


newterm 'echo "Logging in with .ovpn file"; openvpn Lab_Dannyoftheira.ovpn'

# Prompt user for input
read -p "Enter the IP address: " ip_address
read -p "Enter the hostname: " hostname


# https://www.linuxjournal.com/content/validating-ip-address-bash-script
function valid_ip()
{
    local  ip=$1
    local  stat=1
    	

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
        
        # verify that we received only one argument:
        if [ $# -gt 1 ]
  	then
    	    echo "Failed validation, additional data supplied."
    	    stat=1
	fi
    fi
    return $stat
}

# validate IP Address
if ! valid_ip $ip_address 
then 
    echo "Invalid IP Address defined" 
    exit 0 
fi


echo "valid ip: $ip_address"
