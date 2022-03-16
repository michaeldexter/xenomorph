#!/bin/sh
#-
# SPDX-License-Identifier: BSD-2-Clause-FreeBSD
#
# Copyright 2021, 2022 Michael Dexter. All rights reserved

. ./lib_xenomorph.sh || \
	{ echo lib_xenomorph.sh failed to read ; exit 1 ; }

echo ; echo What Dom0 root directory?
echo -n "(root directory): " ; read dom0_root

echo ; echo How much Dom0 RAM? i.e. 4096, 8g, 16g
echo -n "(Dom0 RAM): " ; read dom0_mem

echo ; echo How many Dom0 CPUs? i.e. 2, 4, 8
echo -n "(Dom0 CPUs): " ; read dom0_cpus

uefi_string=""
echo ; echo Will the target system boot UEFI?
echo -n "(y/n): " ; read uefi
if [ "$uefi" = "y" ] ; then
	uefi_string="-e"
fi

serial_string=""
echo ; echo Enable serial output?
echo -n "(y/n): " ; read serial
if [ "$serial" = "y" ] ; then
	serial_string="-s"
fi

xenomorph -r $dom0_root -c $dom0_cpus -m $dom0_mem $uefi_string $serial_string
