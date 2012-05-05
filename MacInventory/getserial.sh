#!/bin/sh

#  getserial.sh
#  MacInventory
#
#  Created by joseph gimenez on 4/28/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

# searches for line with "IOPlatformSerialNumber" string
# Parses out string at characters 37-48

ioreg -l | grep IOPlatformSerialNumber | cut -c 37-48
