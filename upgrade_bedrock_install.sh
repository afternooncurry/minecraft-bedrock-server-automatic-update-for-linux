#!/bin/bash

# Stop becrock service (make the user be sudoers of passwordless in advance)
echo "Stopping system service..."
sudo systemctl stop bedrock

# Backup config files
echo "Copying the current setting files into the backup directory..."
cp ./server.properties ./backup/server.properties
cp ./permissions.json ./backup/permissions.json
cp ./allowlist.json ./backup/allowlist.json

# Extract the downloaded zip file and overwrite the existing files
echo "Extracting the Bedrock server zip file $1 ..."
unzip -o $1 2>&1 > /dev/null

# Restoring config files which were backed up in advance
echo "Restoring the setting files from the backup directory ..."
cp ./backup/server.properties ./server.properties
cp ./backup/permissions.json ./permissions.json
cp ./backup/allowlist.json ./allowlist.json

# Start bedrock service
echo "Start system service ..."
sudo systemctl start bedrock

echo "completed to update the Bedrock server to $1"
