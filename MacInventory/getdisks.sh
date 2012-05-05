#!/bin/sh

#  getdisks.sh
#  MacInventory
#
#  Created by joseph gimenez on 4/28/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

#Grab line that begins with 0:
#This line shows the total disk size on column 3 (whitespace delimiter)
diskutil list | awk '/0:/ { print $3; }'
