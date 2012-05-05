#!/bin/sh

#  getmodel.sh
#  MacInventory
#
#  Created by joseph gimenez on 4/28/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

ioreg -l -d2 | grep compatible | cut -c 26-38