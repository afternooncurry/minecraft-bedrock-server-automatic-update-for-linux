# Minecraft Bedrock Server Automatic Update for Linux

# Assumption
1. The OS is Ubuntu 22.04 or upper
1. The username for running the Bedrock server is "minecraft"
1. The group for running Bedrock server is "minecraft"
1. The directory where the existing bedrock server install directory is `/opt/minecraft/bedrock-server`

# Prerequisite
1. The user "minecraft" is configured as sudoers of passwordless (because the script stops and starts bedrock server as system service)

# How to use
1. git clone this repository
1. Open `bedrock_update.sh` and update the value of `BEDROCK_SERVER_DIR` depending on your environment. Specify the exising bedrock-server directory where the `bedrock_server` executable exists.
1. Open `bedrock.service` and update `User`, `Group`, `WorkingDirectory`. `Environment` and `ExecStart` depending on your environment.
1. Copy the `bedrock.service` into `/etc/systemd/system/`
1. Test if the service `bedrock` can be started by `systemctl start bedrock` and stopped by `systemctl stop bedrock` 
1. Test the script by executing `bedrock_update.sh` using the absolute path, ex. `bash /opt/minecraft/minecraft-bedrock-server-automatic-update-for-linux/bedrock_server.sh`
1. Once you confirmed this script works, register this as job in your crontab, ex. `30 * * * * /opt/minecraft/minecraft-bedrock-server-automatic-update-for-linux/bedrock_update.sh` for checking the update every 30 minutes.

## Note: 
- The downloade zip files of bedrock server (stored under the bedrock server install directory) are not deleted automatically. Please delete them by yourself if the volumn of them becomes large.
