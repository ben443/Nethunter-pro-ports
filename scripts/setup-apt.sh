#!/usr/bin/env sh

DEBIAN_SUITE=$1
SUITE=$2
CONTRIB=$3
NONFREE=$4

COMPONENTS="main"
[ "$CONTRIB" = "true" ] && COMPONENTS="$COMPONENTS contrib"
[ "$NONFREE" = "true" ] && COMPONENTS="$COMPONENTS non-free non-free-firmware"

# Add source repo
if [ "$DEBIAN_SUITE" = "kali-rolling" ]; then
  echo "#deb-src http://http.kali.org/kali kali-rolling $COMPONENTS" >> /etc/apt/sources.list
fi
