#!/bin/bash

function antipebkac {
  gamepath=${1%%244850*}
  gamedatapath=${1%%244850*}244850/pfx/drive_c/users/steamuser/AppData/Roaming/SpaceEngineers
}


WINETRICKSVER=$(winetricks --version|awk {'print $1}')
#echo $WINETRICKSVER
echo "Checking winetricks..."
if [ "$WINETRICKSVER" -ge "20240105" ]; then
  sleep 1
  echo "winetricks is up to date!"
else
  echo "winetricks is NOT up to date! Please update winetricks to 20240105 or later"
fi




sleep 1
echo "In order to proceed it is advised to make a backup of your Space Engineers data."



#if false; then
#
#if [ -d "~/.steam/steam/steamapps/compatdata/244850/pfx/drive_c/users/steamuser/AppData/Roaming/SpaceEn>
#  NATIVE=y
#else
#  NATIVE=n
#fi
#
#if [ -d "~/.var/app/com.valvesoftware.Steam/.steam/root/steamapps/compatdata/244850/pfx/drive_c/users/s>
#  FLATPAK=y"
#else
#  FLATPAK=n
#fi
#
#case $NATIVE$FLATPAK in
#
#  yy)
#    echo "Native and Flatpak install found! Please manually input your desired install to be targeted."
#    read -r INSTALLTARGET
#    ;;
#
#  yn)
#    echo "Native install found! Continue with native? (y/n): "
#    read -r NATIVECONFIRM
#    ;;
#
#  ny)
#    echo "Flatpak install found! Continue with Flatpak? (y/n): "
#    read -r FLATPAKCONFIRM
#    ;;
#
#  nn)
#    echo "No install found. Please manually input target 244850 directory: "
#    read -r INSTALLTARGET
#    ;;
#
#esac
#
#fi


echo -n "Where is your SpaceEngineers pfx directory: "
read -r pebkacpath

antipebkac $pebkacpath

echo "$gamedatapath will be backed up"

mkdir ~/SE-BACKUP
tar -cvf ~/SE-BACKUP/SpaceEngineersAppDataBackup.tar $gamedatapath

echo "Backup made and can be found in ~/SE-BACKUP."
sleep 2
