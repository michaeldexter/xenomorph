#!/bin/sh
#-
# SPDX-License-Identifier: BSD-2-Clause-FreeBSD
#
# Copyright 2021, 2022, 2025 Michael Dexter. All rights reserved

. ./lib_xenomorph.sh || \
	{ echo lib_xenomorph.sh failed to read ; exit 1 ; }

# Defaults

echo ; echo "What Dom0 root directory?"
echo -n "root directory. Default is "/" for installing to the host: "
read dom0_root
[ -n "$dom0_root" ] || dom0_root="/"

echo ; echo "How much Dom0 RAM? i.e. 4096M, 8G, 16G - Must have unit"
echo -n "Dom0 RAM. Default is 4096M: " ; read dom0_mem
[ -n "$dom0_mem" ] || dom0_mem="4096M"

echo ; echo "How many Dom0 CPUs? i.e. 2, 4, 8 - Deafult is 2"
echo -n "Dom0 CPUs. Default is 2: " ; read dom0_cpus
[ -n "$dom0_cpus" ] || dom0_cpus=2

xenomorph -r $dom0_root -c $dom0_cpus -m $dom0_mem
