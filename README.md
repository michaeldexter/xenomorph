## xenomorph.sh and xendomains.sh - Draft FreeBSD Xen Dom0 configuration and management scripts

This is proof of concept FreeBSD 13.0 Xen configuration and "xendomains" VM management script

The basic Xen enablement works and the needed improvements to xendomains can be followed in this review:

https://reviews.freebsd.org/D28551

With that in mind the xendomains.sh script can be tested as:

/usr/local/etc/rc.d/xendomains

It can be enabled with:

service xendomains onestart

Note that UEFI boot should be supported in 14 MAIN


This is not an endorsement of GitHub
