#!/bin/sh
#
# $FreeBSD$
#

# PROVIDE: xendomains
# REQUIRE: FILESYSTEMS

. /etc/rc.subr

name="xendomains"
desc="Manage Xen Domains"
rcvar="xendomains_enable"

start_cmd="xendomains_start"
stop_cmd="xendomains_stop"
status_cmd="xendomains_status"
extra_commands="status"
: ${xendomains_cmd:=/usr/local/sbin/xl}
: ${xendomains_dir:=/usr/local/etc/xen/auto}

xendomains_status()
{
	${xendomains_cmd} list | awk '
		(FNR <= 2) { next }
		($5 !~ /s/) { s = s " " $1 }
		END { sub(" *", "", s); print s }'
}

xendomains_start()
{
	echo 'Starting Xen Domains'
	for domain in ${xendomains_dir}/* ; do
		${xendomains_cmd} create ${domain}
	done
}

xendomains_stop()
{
	echo 'Stopping Xen Domains'

	${xendomains_cmd} list | awk '
		(FNR <= 2) { next }
		($5 !~ /s/) { s = s " " $1 }
		END { sub(" *", "", s); print s }' | tr ' ' '\n' | \
			while read domain ; do
				echo Stopping Xen domain $domain
				${xendomains_cmd} shutdown -F ${domain}
			done
}

load_rc_config $name
run_rc_command "$1"
