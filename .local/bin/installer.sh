#!/bin/sh

# Author : Daniel Cordova
# E-Mail : danesc87@gmail.com
# Github : @dcdaz

# Script that allows to use same aliases for different OSs,
# like ref to update repos or u to upgrade all available packages

# Common options
ACTION="$1"

# All available commands by OS goes here
declare -A options='(
  [debian,update]="sudo apt-get update"
  [debian,upgrade]="sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade"
  [debian,dist-upgrade]="sudo DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade"
  [debian,install]="sudo apt-get install"
  [debian,remove]="sudo apt-get remove --purge"
  [debian,search]="apt-cache search"
  [debian,info]="apt-cache show"
  [debian,orphans]="echo Not implemented yet!"
  [debian,unneeded]="echo Not implemented yet!"
  [debian,manual]="sudo dpkg"

  [suse,update]="sudo zypper ref"
  [suse,upgrade]="sudo zypper up"
  [suse,dist-upgrade]="sudo zypper dup"
  [suse,install]="sudo zypper in"
  [suse,remove]="sudo zypper remove -u"
  [suse,search]="zypper search"
  [suse,info]="zypper if"
  [suse,orphans]="zypper packages --orphaned"
  [suse,unneeded]="zypper packages --unneeded"
  [suse,manual]="sudo zypper"

  [arch,update]="sudo pacman -Sy"
  [arch,upgrade]="sudo pacman -Su"
  [arch,dist-upgrade]="echo Not implemented yet!"
  [arch,install]="sudo pacman -S"
  [arch,remove]="sudo pacman -R"
  [arch,search]="pacman -Ss"
  [arch,info]="echo Not implemented yet!"
  [arch,orphans]="echo Not implemented yet!"
  [arch,unneeded]="echo Not implemented yet!"
  [arch,manual]="sudo pacman"

  [mac,update]="brew update"
  [mac,upgrade]="brew upgrade"
  [mac,dist-upgrade]="echo Not implemented yet!"
  [mac,install]="brew install"
  [mac,remove]="brew uninstall"
  [mac,search]="brew search"
  [mac,info]="brew info"
  [mac,orphans]="echo Not implemented yet!"
  [mac,unneeded]="echo Not implemented yet!"
  [mac,manual]="echo Not implemented yet!"
)'

function run_command {
  shopt -s nocasematch
  if [ $(uname) == "Darwin" ]; then
    ${options["mac",$ACTION]} $@
  elif [[ $(cat /etc/issue) =~ "debian" ]]; then
      ${options["debian",$ACTION]} $@
  elif [[ $(cat /etc/issue) =~ "suse" ]]; then
      ${options["suse",$ACTION]} $@
  else
      ${options["arch",$ACTION]} $@
  fi
}

if [ -z $ACTION ]; then
    echo "This script must have an action update/upgrade/install/remove/search/info"
    exit 1
fi

run_command ${@:2}

exit 0