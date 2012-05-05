#!/bin/sh

#  getram.sh
#  MacInventory
#
#  Created by joseph gimenez on 4/28/12.
#  Copyright (c) 2012 PeopleMatter. All rights reserved.

hostinfo | grep Primary | cut -c 27-40