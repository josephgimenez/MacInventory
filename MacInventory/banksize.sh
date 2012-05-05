#!/bin/sh

#  banksize.sh
#  MacInventory
#
#  Created by joseph gimenez on 4/28/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

# This works by returning a large amount of information about the memory installed
# We filter out the lines where "Size" string is found
# We then print the 2nd column (i.e., the second item using whitespace as delimiter), which is the RAM size in GB.

system_profiler -detailLevel mini SPMemoryDataType | awk '/Size/ {print $2;}'

