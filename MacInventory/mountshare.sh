#!/bin/sh

#  mountshare.sh
#  MacInventory
#
#  Created by joseph gimenez on 4/29/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

#echo "You passed in username: $1 with password: $2"
mkdir ~/smbshare
mount_smbfs //$1:$2@pm-vap-01.peoplematter.com/Belarc/Belarc ~/smbshare