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
if [ -z "$URL" ] ; then
  echo "Download URL of the latest Bedrock server cannot be identified. Stopping the upgrade."
  exit 1
elif [ -f ./${URL##*/} ]; then
  echo "The latest version of Bedrock server already exists. Stopping the upgrade."
  exit 1
else
  # Get new bedrock server zip file from the official web site
  echo "New version of Bedrock server was found. Trying to download ..."
  curl -s -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)" -O ${URL}
fi

if [ -f ./${URL##*/} ]; then
  echo "New version of Bedrock server was gotten downloaded. Trying to update..."
  SCRIPT_DIR=`dirname $(readlink -f $0)`
  bash $SCRIPT_DIR/upgrade_bedrock_install.sh ${URL##*/}
else
  echo "Failed to download the latest Bedrock server. Exiting."
  exit 1
fi

exit 0
