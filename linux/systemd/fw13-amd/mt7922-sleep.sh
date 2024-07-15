#!/bin/sh
##
## URL: https://community.frame.work/t/responded-arch-hibernation-woes-on-amd-13/45474/65
## FILE: /lib/systemd/system-sleep/archlinux-fw13-amd-radios.sh
##
# grab this from lspci or lshw (driver=$wifi)
wifi="mt7921e"
/usr/bin/logger "$0 - radios $1. wifi: $wifi"
if [ "$1" = "pre" ]; then
  /usr/bin/rfkill block all
  /usr/bin/sleep 1
  [ -n "$wifi" ] && /usr/bin/modprobe -r $wifi
fi
if [ "$1" = "post" ]; then
  [ -n "$wifi" ] && /usr/bin/modprobe $wifi
  /usr/bin/sleep 1
  /usr/bin/rfkill unblock all
  /usr/bin/systemctl restart NetworkManager.service
fi
