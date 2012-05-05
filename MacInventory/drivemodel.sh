#!/bin/sh

#  drivemodel.sh
#  MacInventory
#
#  Created by joseph gimenez on 5/3/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

# Filters out all lines from system_profile output with "Model" string
# Prints 2nd and 3rd columns, separated by a space (make of drive if applicable + " " + model)

system_profiler SPSerialATADataType | awk '/Model:/ { print $2 " " $3; }'
