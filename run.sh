#!/bin/bash
clear
echo "Hello and thank you for using SE-prefixxer."
WINETRICKSVER=$(winetricks --version|awk {'print $1'})
#echo $WINETRICKSVER
echo "Checking winetricks..."
if [ "$WINETRICKSVER" -ge "20240105" ]; then
  sleep 1
  echo "winetricks is up to date!"
else
  echo "winetricks is NOT up to date! Please update winetricks to 20240105 or later"
fi


read -p "Do you have protonGE9-3 or later installed on your system? (y/n): " ProtonGE
case $ProtonGE in
  [yY]*)
      echo "Please make sure ProtonGE is set to be used as SE's compatibility tool."
    ;;
  [nN]*)
      echo "Please install protonGE by following this link: https://github.com/GloriousEggroll/proton-ge-custom?tab=readme-ov-file#installation"
      sleep 5
      echo "Please make sure ProtonGE is set to be used as SE's compatibility tool."
      sleep 5
      read -p "Press enter to continue."
    ;;
esac

sleep 1
echo "In order to proceed it is advised to make a backup of your Space Engineers data."
sleep 1
autopath=$(find ~ -type d -name 244850 2> /dev/null |awk 'NR==1{print $1}')/pfx
echo ""
echo "Autodetecting potential pfx directories..."


function antipebkac {
  gamepath=${1%%/244850*}
  gamedatapath=${1%%/244850*}/244850/pfx/drive_c/users/steamuser/AppData/Roaming/SpaceEngineers
}

while true; do
  read -p "Is $autopath your pfx directory? (y/n): " autochoice
  case $autochoice in 
        [yY]*)
          antipebkac $autopath
          break
          ;;
        [nN]*)
          ;;
  esac
  read -p "Where is your SpaceEngineers pfx directory: " pebkacpath
  antipebkac $pebkacpath
  case $gamepath in

    *compatdata)
      echo "Folder to backup is: $gamedatapath"
      break
      ;;

    *)
      echo "Path is not properly defined. Retry!!" >&2
      ;;
  esac
done

echo ""
echo "$gamedatapath will be backed up and the original deleted."
sleep 1
read -p "Is the path correct? (y/n): " deletionimminent
case $deletionimminent in
  [yY]*)
    ;;
  [nN]*)
    echo "Quitting"
    exit 1
    ;;
esac
mkdir -p ~/SE-BACKUP
tar -cf ~/SE-BACKUP/SpaceEngineersAppDataBackup.tar $gamedatapath

echo "Backup made and can be found in ~/SE-BACKUP."
sleep 2
rm -rf $gamepath/244850
read -p "Please set your proton to GE9-3 or higher and run SE again with proton9-3 (enter to continue)"

WINEARCH=win64 WINEPREFIX=$gamepath/244850/pfx winetricks --force -q dotnet48
