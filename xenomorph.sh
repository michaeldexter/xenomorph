#!/bin/sh

# Copyright 2021 Michael Dexter. All rights reserved

[ $(sysctl -n machdep.bootmethod) = BIOS ] || \
	{ echo Only BIOS/Legacy booting is supported. Exiting ; exit 1 ; }

which xl || \
{ echo Xen packages missing - pkg install xen-tools xen-kernel ; exit 1 ; }

# Still required?
#[ -d /var/lock ] || mkdir /var/lock
#[ -d /var/run/xen ] || mkdir /var/run/xen

grep "vm.max_user_wired" /etc/sysctl.conf || echo "vm.max_user_wired=-1" >> /etc/sysctl.conf
tail /etc/sysctl.conf

grep "xc0" /etc/ttys || echo "xc0     \"/usr/libexec/getty Pc\"         xterm   onifconsole  secure" >> /etc/ttys
tail /etc/ttys

grep "xen_kernel" /boot/loader.conf || echo "xen_kernel=\"/boot/xen\"" >> /boot/loader.conf
grep "xen_cmdline" /boot/loader.conf || \
echo "xen_cmdline=\"dom0_mem=2048M dom0_max_vcpus=4 dom0=pvh com1=115200,8n1 guest_loglvl=all loglvl=all\"" \
	>> /boot/loader.conf
# Add console=com1 to enable the serial console
grep "if_tap_load" /boot/loader.conf || echo if_tap_load=\"YES\" >> /boot/loader.conf
tail /boot/loader.conf

# Probably obsolete
#grep xen.4th /boot/menu.rc.local  || echo "try-include /boot/xen.4th" >> /boot/menu.rc.local

sysrc xencommons_enable=YES

# https://svnweb.freebsd.org/ports/head/emulators/xen-kernel/pkg-message?view=markup

exit 0
