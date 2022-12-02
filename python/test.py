#!/usr/bin/env python3

from ntopng import ntopng
from interface import interface
from host import host
import os

my_ntopng = ntopng('admin', 'lucaderi', 'http://localhost:3000')

ifid = 4

my_interface = interface(my_ntopng)
#my_interface.self_test(ifid)

my_host = host(my_ntopng)
my_host.self_test(ifid)

os._exit(0)
