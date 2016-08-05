#!/usr/bin/env bash

cd /data/containerdata/ark1

if [ ${CHECKFILES} == "true" ]; then
	ARKVALIDATE="validate"
fi

# Get steamcmd
if [ ! -f steamcmd_linux.tar.gz ]; then
        echo -e "Grabbing SteamCMD...\n"
        wget -q https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
        tar -xf steamcmd_linux.tar.gz
fi

# Backup before updating just to be safe
if [ -d /data/containerdata/ark1/arkdedicated/ShooterGame/Saved ]; then
        echo -e "Backing up Saved folder...\n"
	if [ ! -d /data/containerdata/ark1/backup/ ]; then
		mkdir /data/containerdata/ark1/backup/
	fi
	tar czf /data/containerdata/ark1/backup/Saved-startup_$(date +%Y-%m-%d_%H-%M).tar.gz /data/containerdata/ark1/arkdedicated/ShooterGame/Saved
fi


# Update / install server
echo -e "Updating ARK...\n"
./steamcmd.sh +login anonymous +force_install_dir /data/containerdata/ark1/arkdedicated +app_update 376030 ${ARKVALIDATE} +quit


# Start ARK
cd /data/containerdata/ark1/arkdedicated/ShooterGame/Binaries/Linux/
export LD_LIBRARY_PATH=/data/containerdata/ark1/arkdedicated/

echo -e "Launching ARK Dedicated Server...\n"

./ShooterGameServer TheCenter?MaxPlayers=70?KickIdlePlayersPeriod=2400.000000?AutoSavePeriodMinutes=20.000000?RCONEnabled=True?RCONPort=32330?QueryPort=27015?Port=7778?GameModIds=630601751?listen -UseBattlEye -automanagedmods -server -log