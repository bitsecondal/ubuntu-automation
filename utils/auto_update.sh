#!/bin/bash

################################################################################
# Script: auto_update.sh
# Description: Script to automatically perform
# functions on ubuntu based servers.
# Author: Kenny Robinson, Bit Second
# Date: 2016-02-28
#
# Version History
# 2016-02-28 - Initial version.
# 2017-05-18 - Updated to use full file path commands intead of only script names.
# 2017-06-03 - Updated if condition to see if script is being ran as root.
################################################################################

# MAKE SURE THAT THE ROOT USER IS RUNNING THE SCRIPT.
if [ "$(id -u)" == "0" ]; then
	/usr/bin/apt-get autoremove --purge -y

	/usr/bin/apt-get clean

	/usr/bin/apt-get update

	/usr/bin/apt-get upgrade -y

	# IF REBOOT FILE HAS BEEN CREATED, THEN DO REBOOT
	if [ -f /var/run/reboot-required ]; then
		/sbin/reboot
	fi
else
	# THROW ERROR IF NOT RUNNING AS ROOT
	/bin/echo "ERROR: Must be root to run script."
fi

