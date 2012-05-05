#!/bin/sh

#  bankspeed.sh
#  MacInventory
#
#  Created by joseph gimenez on 4/28/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

#Output memory information from system_profiler
#Filter out all lines with "Speed" string
#Print 2nd column of line (whitespace delimiter), which contains RAM speed in mhz

system_profiler -detailLevel mini SPMemoryDataType | awk '/Speed/ {print $2;}'
