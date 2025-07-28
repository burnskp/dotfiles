# Firejail profile for legcord
# Persistent local customizations
#include legcord.local
# Persistent global definitions
#include globals.local

### Basic Blacklisting ###
### Enable as many of them as you can! A very important one is
### "disable-exec.inc". This will make among other things your home
### and /tmp directories non-executable.
include disable-common.inc	# dangerous directories like ~/.ssh and ~/.gnupg
include disable-devel.inc	# development tools such as gcc and gdb
include disable-exec.inc	# non-executable directories such as /var, /tmp, and /home
include disable-interpreters.inc	# perl, python, lua etc.
#include disable-programs.inc	# user configuration for programs such as firefox, vlc etc.
#include disable-shell.inc	# sh, bash, zsh etc.
#include disable-xdg.inc	# standard user directories: Documents, Pictures, Videos, Music

### Home Directory Whitelisting ###
whitelist ${HOME}/.config/electron-flags.conf
whitelist ${HOME}/.config/vulkan
whitelist ${HOME}/.local/share/vulkan/loader_settings.d
whitelist ${HOME}/.config/legcord
whitelist ${HOME}/share/discord
include whitelist-common.inc

### Filesystem Whitelisting ###
include whitelist-run-common.inc
whitelist ${RUNUSER}/pulse
whitelist ${RUNUSER}/discord-ipc-0
include whitelist-runuser-common.inc
include whitelist-usr-share-common.inc
include whitelist-var-common.inc

caps.drop all
ipc-namespace
netfilter
nodvd	# disable DVD and CD devices
nonewprivs
#noroot
protocol unix,inet,inet6,netlink,
netfilter
seccomp !chroot	# allowing chroot, just in case this is an Electron app
shell none
#tracelog	# send blacklist violations to syslog

disable-mnt
private-cache
#private-etc machine-id,pulse,ca-certificates,libva.conf,vulkan,ati,hosts,fonts,xdg,gtk-3.0,dconf,svc.conf,netsvc.conf,nsswitch.conf,resolv.conf,os-release,drirc,gnutls,login.defs,
private-tmp

dbus-user filter
dbus-user.talk org.freedesktop.Notifications
dbus-user.talk org.mozilla.*
ignore dbus-user none
ignore dbus-system none

join-or-start legcord

# Redirect
include /etc/firejail/electron.profile
