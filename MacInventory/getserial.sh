#!/bin/sh

#  getserial.sh
#  MacInventory
#
#  Created by joseph gimenez on 4/28/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

ioreg -l | grep IOPlatformSerialNumber | cut -c 37-48