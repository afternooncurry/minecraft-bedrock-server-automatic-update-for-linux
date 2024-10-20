#!/bin/bash
##
## Automated Minecraft Bedrock Server Updater for Linux
## Created by Minory, Jun 30, 2021
##

# Specify the directory which holds your Bedrock server files
BEDROCK_SERVER_DIR=/opt/minecraft/bedrock-server

# The scripts start here. Do not change from here.
cd $BEDROCK_SERVER_DIR

# Create a "backup" directly if it does not exist
mkdir -p backup

# Randomizer for user agent
RandNum=$(echo $((1 + $RANDOM % 5000)))

# Pickup URL to download stable bedrock server only
URL=`curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.33 (KHTML, like Gecko) Chrome/90.0.$RandNum.212 Safari/537.33" https://minecraft.net/en-us/download/server/bedrock/ 2>/dev/null | grep bin-linux/ | sed -e 's/.*<a href=\"\(https:.*\/bin-linux\/.*\.zip\).*/\1/'`

# Verify if the DOWNLOAD and SERVER destinations exist. Create if it doesn't
if [ -f ./${URL##*/} ]; then
  exit 1
else
  echo "New version of Bedrock server was found. trying to update."

  # Stop becrock service (make the user be sudoers of passwordless in advance)
  sudo systemctl stop bedrock

  # Backup config files
  cp ./server.properties ./backup/server.properties
  cp ./permissions.json ./backup/permissions.json
  cp ./allowlist.json ./backup/allowlist.json

  # Get new bedrock server zip file from the official web site
  curl -s -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)" -O ${URL}

  # extract the downloaded zip file and overwrite the existing files
  unzip -o ${URL##*/} 2>&1 > /dev/null

  # Return config files which were backup in advance
  cp ./backup/server.properties ./server.properties
  cp ./backup/permissions.json ./permissions.json
  cp ./backup/allowlist.json ./allowlist.json

  # Start bedrock service
  sudo systemctl start bedrock

  echo "completed to update the Bedrock server to ${URL##*/}"
fi

exit 0
