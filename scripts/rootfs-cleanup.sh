#!/usr/bin/env sh

## REF: https://gitlab.com/kalilinux/build-scripts/kali-vm/-/blob/main/scripts/finish-install.sh
configure_apt_sources_list() {
    # make sources.list empty, to force setting defaults
    echo > /etc/apt/sources.list

    if grep -q '^deb ' /etc/apt/sources.list; then
        echo "INFO: sources.list is configured, everything is fine"
        return
    fi

    echo "INFO: sources.list is empty, setting up a default one for Kali"

    cat >/etc/apt/sources.list <<END
# See https://www.kali.org/docs/general-use/kali-linux-sources-list-repositories/
deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware

# Additional line for source packages
# deb-src http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware
END
    apt-get update
}
configure_apt_sources_list

# Remove apt packages which are no longer unnecessary and delete
# downloaded packages
apt -y autoremove --purge
apt clean

# Remove machine ID so it gets generated on first boot
rm -vf /var/lib/dbus/machine-id
echo uninitialized > /etc/machine-id

# FIXME: these are automatically installed on first boot, and block
# the system startup for over 1 minute! Find out why this happens and
# avoid this nasty hack
rm -vf /lib/systemd/system/wpa_supplicant@.service \
       /lib/systemd/system/wpa_supplicant-wired@.service \
       /lib/systemd/system/wpa_supplicant-nl80211@.service
