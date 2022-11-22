#!/bin/sh

set -ex

apk add libressl
apk add open-vm-tools
apk add open-vm-tools-guestinfo

rc-update add open-vm-tools boot

cat >/usr/local/bin/shutdown <<EOF
#!/bin/sh
poweroff
EOF
chmod +x /usr/local/bin/shutdown

sed -i "/#PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config

rc-service sshd restart

echo '> Cleaning filesystem...'

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sync
sync
sync
rm -f setup.sh