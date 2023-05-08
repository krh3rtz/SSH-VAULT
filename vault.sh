#!/bin/bash

# Default variables
configf=~/.ssh/config
keysv=~/.ssh/VAULT

# Validate existance of global Vault
if [[ ! -d $keysv ]]
then
   mkdir $keysv;
fi

if [[ ! $1 || ! $2 || ! $3 || ! $4  ]]; then
    echo "[*] Incomplete parameters:";
    echo "Options: $0" ;
    echo "Example: $0 <ssh_user> <server_fqdn_or_ip> <ssh_remote_port> <vault_name>";
    exit;
fi;

# Program Variables
user=$1
server=$2
port=$3
vault=$4

echo "[+] Generating Vault for $vault "

# Validate existance of server vault
if [[ -d $keysv/$vault ]]
then
    echo "[?] A vault for this server already exists"
else
    mkdir $keysv/$vault
fi

echo "[+] Generating Keys for $user@$server"

# Validate user existance in vault
if [[ -d $keysv/$vault/$user ]]
then
    echo "[?] A user alreasdy exists in this vault. Do you wish to overwrite existing keys for this user?."
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) rm -rf $keysv/$vault/$user/*;break;;
            No ) exit;;
        esac
    done
fi

echo "[+] Adding a new pair of keys to the vault for user $user"
mkdir $keysv/$vault/$user

ssh-keygen -t rsa -b 2048 -f $keysv/$vault/$user/$user

# Copy ssh public key to the remote server
echo "[?] Do you wish to copy the keys to the remote server?."
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) ssh-copy-id -i $keysv/$vault/$user/$user".pub" -p $port $user@$server ;break;;
            No ) break;;
        esac
    done

echo "[+] Adding connection to config file"

echo "Host $vault"_"$user
	HostName	$server
	User		$user
    Port        $port
	IdentityFile	$keysv/$vault/$user/$user" >> $configf

echo "[+] Done! Please try connecting with ssh $vault"_"$user"