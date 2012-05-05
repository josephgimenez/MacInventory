#!/bin/sh

#  drivemodel.sh
#  MacInventory
#
#  Created by joseph gimenez on 5/3/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

system_profiler SPSerialATADataType | awk '/Model:/ { print $2 " " $3; }'