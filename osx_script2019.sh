#!/bin/bash

SECONDS=0

RED='\033[0;31m'
NC='\033[0m'

#Make sure you are able to sudo to root
sudo -nv 2>>/dev/null
if [ $? -ne 0 ]; then
    printf "Black Hat macOS Config requires root access.\\n"
    printf "Please enter your password, or run 'sudo -v' first.\\n"
    sudo -v

    #Confirm ability to sudo
    if [ $? -ne 0 ]; then
      printf "\\n"
      printf "Not Able to Sudo. Exiting\\n"
      exit
    fi
    printf "\\n"
fi


#Require Password
printf "Password immediately after Sleep or ScreenSaver\\n"
defaults write com.apple.screensaver askForPassword 1 > /dev/null 2>&1
defaults write com.apple.screensaver askForPasswordDelay 0 > /dev/null 2>&1


#Enable Firewall:
printf "Enabling Firewall....\\n"
defaults write /Library/Preferences/com.apple.alf globalstate 1  > /dev/null 2>&1

printf "Stealth Firewall Mode enabling....\\n"
defaults write /Library/Preferences/com.apple.alf stealthenabled 1 > /dev/null 2>&1

printf "Installing needed updates....please wait\\n"
softwareupdate -i -a > /dev/null 2>&1

printf "Turning on Automatic Updates"
softwareupdate --schedule on > /dev/null 2>&1

printf "Disable All Remote Logins....."
systemsetup -f -setremotelogin off > /dev/null 2>&1

#Enabling Firevault:
printf "Enabling FileVault Encryption......\\n"
fdesetup enable  > /dev/null 2>&1

timed="$((SECONDS / 3600)) Hours $(((SECONDS / 60) % 60)) Minutes $((SECONDS % 60)) seconds"
printf "It Took %s to complete this script.\\n" "$timed"
