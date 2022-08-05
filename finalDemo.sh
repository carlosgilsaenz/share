#!/bin/bash

# Define Variables
logfile=$HOME/research/sys_info.log

# Check for research directory. Create it if needed.
if [ ! -d $HOME/research ]; then
  mkdir $HOME/research
fi

# Check for output file. Clear it if needed.
if [ -f $logfile ]; then
  >$logfile
fi

# Check if script was run as root. Exit if false.
if [ $UID -ne 0 ]; then
  echo "Please run this script as root."
  exit
fi

# create timestamp within logfile
echo "This log is generated on $(date)" >> $logfile

# create list of packages
packages=(
    'nano',
    'wget',
    'tree',
    'net-tools',
    'python',
    'tripwire',
    'curl'
)

# iterate through list and install
for package in ${packages[@]}
    do
        which $package > /dev/null 2>&1
        if [ $? != 0 ]
        then
            echo "Package $package already installed"
        else
            echo "Package $package is not install"
            #apt install -y $package
        fi
    done

# Remove roots login shell and lock account
usermod -s /sbin/nologin root
usermod -L root

chmod 640 /etc/shadow
chmod 640 /etc/gshadow
chmod 644 /etc/group
chmod 644 /etc/passwd
