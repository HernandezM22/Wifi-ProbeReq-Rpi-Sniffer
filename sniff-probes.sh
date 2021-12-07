#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin/:/usr/sbin:/usr/bin:/sbin:/bin
OUTPUT="${OUTPUT:-probes.txt}"
CHANNEL_HOP="${CHANNEL_HOP:-0}"

# channel hop every 2 seconds
channel_hop() {

	IEEE80211bg="1 2 3 4 5 6 7 8 9 10 11"
	IEEE80211bg_intl="$IEEE80211b 12 13 14"
	IEEE80211a="36 40 44 48 52 56 60 64 149 153 157 161"
	IEEE80211bga="$IEEE80211bg $IEEE80211a"
	IEEE80211bga_intl="$IEEE80211bg_intl $IEEE80211a"

	while true ; do
		for CHAN in $IEEE80211bg ; do
			# echo "switching $IFACE to channel $CHAN"
			sudo iwconfig $IFACE channel $CHAN
			sleep 2
		done
	done
}

if ! [ -x "$(command -v gawk)" ]; then
  echo 'gawk (GNU awk) is not installed. Please install gawk.' >&2
  exit 1
fi

if [ "$CHANNEL_HOP" -eq 1 ] ; then
	# channel hop in the background
	channel_hop &
fi

# filter with awk, then use sed to convert tabs to spaces and remove front and back quotes around SSID
timeout 300s tcpdump -i "wlan1mon" -e -s 256 subtype probe-req | awk -f parse-tcpdump.awk | tee -a "$OUTPUT" 
echo "Calling manager.sh"
sh ./connector.sh

