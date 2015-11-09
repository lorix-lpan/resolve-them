#!/bin/bash

## A platform independent bash script that automatically
## install the dependencies for your app.
##
## Created by Lawrence Pan <lawrence_pan@hot-shot.com>
## Licensed under GNU GPLv3
## Code: https://github.com/lorix-lpan
## Last edit: November 8, 2015

# Global variables
# Your name
AUTHOR_NAME="Lawrence Pan"
AUTHOR_EMAIL="lawrence_pan@hot-shot.com"
# The name of your application
APP_NAME="Alleles fixation simulation"
# Command to launch the program
LAUNCH_NAME="alleles-fixation"
# The package managers supported by this script
SUPPORTED_PMS=("apt-get" "pacman")
# Lists of dependencies with different names for different distro
PACKAGE_LIST_ARCH=("python-pyqt5" "python-setuptools")
PACKAGE_LIST_DEB=("python3-pyqt5" "python3-setuptools")
# String contains a list of missing packages
MISSING_LIST=""
# Name of the package manager
PACM=""
# Update package list, ex. sudo apt-get update
UPDATE_COMMAND="sudo"
# Install package(s), ex. sudo pacman -S python
INSTALL_COMMAND="sudo"
# Check if package is installed ex. pacman -Q python
CHECK_COMMAND=""

# Return True if the program is installed
# $1 => possible package manager name
have_installed() {
  [ -x "$(which $1)" ]
}

# Check what package manager is installed
# Assign value to PACM if it contains a empty string
check_package_manager(){
  if [[ "$PACM" == "" ]];then
    for i in ${SUPPORTED_PMS[@]};do
      if have_installed $i > /dev/null 2>&1;then
        PACM="$i"
        break
      fi
    done
  fi
}

# Filter the list of packages
# Then append the missing ones to the install command
# $1 => list of packages
determine_package(){
  local arr=("$@")
  for i in ${arr[@]};do
    if ! eval "$CHECK_COMMAND $i" > /dev/null 2>&1;then
      INSTALL_COMMAND+=" $i"
      MISSING_LIST+="$i "
    else
      continue
    fi
  done
}

# Determine the install&update&check command according to the pm
determine_command(){
  if [[ "$PACM" == "apt-get" ]];then
    UPDATE_COMMAND+=" apt-get update"
    INSTALL_COMMAND+=" apt-get install"
    CHECK_COMMAND=" dpkg -s"
    determine_package "${PACKAGE_LIST_DEB[@]}"
  elif [[ "$PACM" == "pacman" ]];then
    UPDATE_COMMAND+=" pacman -Syu"
    INSTALL_COMMAND+=" pacman -S"
    CHECK_COMMAND="pacman -Q"
    determine_package "${PACKAGE_LIST_ARCH[@]}"
  else
    echo "error!"
    exit
  fi
}

# Install the missing dependencies if there are any
install_depend(){
  if [[ "$MISSING_LIST" == "" ]];then
    echo "Dependencies are already successfully installed"
  else
    echo "$MISSING_LIST will be installed"
    eval "$UPDATE_COMMAND"
    eval "$INSTALL_COMMAND"
    # Check if they are installed successfully
    MISSING_LIST=""
    determine_command
    install_depend
  fi
}

# Program starts here
echo ":: Installing $APP_NAME"
check_package_manager
echo "$PACM found"
echo "resolving dependencies..."
determine_command
install_depend
echo "Success!"

###### Your procedures go here ######
