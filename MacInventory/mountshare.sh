#!/bin/sh

#  mountshare.sh
#  MacInventory
#
#  Created by joseph gimenez on 4/29/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

mkdir ~/smbshare

# Mounts samba share (i.e., windows share)
# Uses argv[0] ($1) and argv[1] as password and mounts Belarc remote share as /Users/username/smbshare locally
mount_smbfs //$1:$2@pm-vap-01.peoplematter.com/Belarc/Belarc ~/smbshare
