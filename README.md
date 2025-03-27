# SSH-VAULT
Simple script for basically managing ssh keys and handle connections

This script simply creates a pair of keys for every user in a server. The way it works is by
creating a "Vault". This corresponds to every server that is going to handle the connection to.

Every vault will create a folder that will contain a folder with users and their correspondin pair of keys.
The foler will live in:

  ~/.ssh/VAULT/

Usage

vault.sh <ssh_user> <server_fqdn_or_ip> <ssh_remote_port> <vault_name>

## ATTENTION: Currently in development
