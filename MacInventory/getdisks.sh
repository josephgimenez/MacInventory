#!/bin/sh

#  getdisks.sh
#  MacInventory
#
#  Created by joseph gimenez on 4/28/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

diskutil list | awk '/0:/ { print $3; }'