# SSH-VAULT
Simple script for basically managing ssh keys and handle connections

This script simoply creates a pair of keys for every user in a server. The way it works is by
creating a "Vault". This corresponds to every server that is going to handle the connection.

Usage
''' console
  vault.sh <ssh_user> <server_fqdn_or_ip> <ssh_remote_port> <vault_name>
 '''
