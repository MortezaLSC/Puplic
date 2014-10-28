#!/bin/bash
echo "Author: MORTEZA"
echo "DATE: Sat Sep 20 16:24:38 IRDT 2014"

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get update -y 
apt-get install tor python-pip python-dev libevent-dev -y
pip install obfsproxy

echo -n "## Configuration file for a typical Tor user
##
## Last updated 22 April 2012 for Tor 0.2.3.14-alpha.
## (may or may not work for much older or much newer versions of Tor.)
##
## Lines that begin with \" ## \" try to explain what's going on. Lines
## that begin with just \" #\" are disabled commands: you can enable them
## by removing the \" #\" symbol.
##
## See 'man tor', or https://www.torproject.org/docs/tor-manual.html,
## for more options you can use in this file.
##
## Tor will look for this file in various places based on your platform:
## https://www.torproject.org/docs/faq#torrc

## Tor opens a socks proxy on port 9050 by default -- even if you don't
## configure one below. Set \"SocksPort 0\" if you plan to run Tor only
## as a relay, and not make any local application connections yourself.
#SocksPort 9050 # Default: Bind to localhost:9050 for local connections.
#SocksPort 127.0.0.1:9050 # Bind to this adddress:port too.

## Entry policies to allow/deny SOCKS requests based on IP address.
## First entry that matches wins. If no SocksPolicy is set, we accept
## all (and only) requests that reach a SocksPort. Untrusted users who
## can access your SocksPort may be able to learn about the connections
## you make.
#SocksPolicy accept 192.168.0.0/16
#SocksPolicy reject *
#ExitNodes {GB}
## Logs go to stdout at level \"notice\" unless redirected by something
## else, like one of the below lines. You can have as many Log lines as
## you want.
##
## We advise using \"notice\" in most cases, since anything more verbose
## may provide sensitive information to an attacker who obtains the logs.
##
## Send all messages of level 'notice' or higher to /var/log/tor/notices.log
#Log notice file /var/log/tor/notices.log
## Send every possible message to /var/log/tor/debug.log
#Log debug file /var/log/tor/debug.log
## Use the system log instead of Tor's logfiles
#Log notice syslog
## To send all messages to stderr:
#Log debug stderr

## Uncomment this to start the process in the background... or use
## --runasdaemon 1 on the command line. This is ignored on Windows;
## see the FAQ entry if you want Tor to run as an NT service.
#RunAsDaemon 1

## The directory for keeping all the keys/etc. By default, we store
## things in $HOME/.tor on Unix, and in Application Data\tor on Windows.
#DataDirectory /var/lib/tor

## The port on which Tor will listen for local connections from Tor
## controller applications, as documented in control-spec.txt.
#ControlPort 9051
## If you enable the controlport, be sure to enable one of these
## authentication methods, to prevent attackers from accessing it.
#HashedControlPassword
#16:872860B76453A77D60CA2BB8C1A7042072093276A3D701AD684053EC4C
#CookieAuthentication 1

############### This section is just for location-hidden services ###

## Once you have configured a hidden service, you can look at the
## contents of the file \".../hidden_service/hostname\" for the address
## to tell people.
##
## HiddenServicePort x y:z says to redirect requests on port x to the
## address y:z.

#HiddenServiceDir /var/lib/tor/hidden_service/
#HiddenServicePort 80 127.0.0.1:80

#HiddenServiceDir /var/lib/tor/other_hidden_service/
#HiddenServicePort 80 127.0.0.1:80
#HiddenServicePort 22 127.0.0.1:22

################ This section is just for relays #####################
#
## See https://www.torproject.org/docs/tor-doc-relay for details.

## Required: what port to advertise for incoming Tor connections.
#ORPort 9001
## If you want to listen on a port other than the one advertised in
## ORPort (e.g. to advertise 443 but bind to 9090), you can do it as
## follows.  You'll need to do ipchains or other port forwarding
## yourself to make this work.
#ORPort 443 NoListen
#ORPort 127.0.0.1:9090 NoAdvertise

## The IP address or full DNS name for incoming connections to your
## relay. Leave commented out and Tor will guess.
#Address noname.example.com

## If you have multiple network interfaces, you can specify one for
## outgoing traffic to use.
# OutboundBindAddress 10.0.0.5

## A handle for your relay, so people don't have to refer to it by key.
#Nickname ididnteditheconfig

## Define these to limit how much relayed traffic you will allow. Your
## own traffic is still unthrottled. Note that RelayBandwidthRate must
## be at least 20 KB.
## Note that units for these config options are bytes per second, not bits
## per second, and that prefixes are binary prefixes, i.e. 2^10, 2^20, etc.
#RelayBandwidthRate 100 KB  # Throttle traffic to 100KB/s (800Kbps)
#RelayBandwidthBurst 200 KB # But allow bursts up to 200KB/s (1600Kbps)

## Use these to restrict the maximum traffic per day, week, or month.
## Note that this threshold applies separately to sent and received bytes,
## not to their sum: setting \"4 GB\" may allow up to 8 GB total before
## hibernating.
##
## Set a maximum of 4 gigabytes each way per period.
#AccountingMax 4 GB
## Each period starts daily at midnight (AccountingMax is per day)
#AccountingStart day 00:00
## Each period starts on the 3rd of the month at 15:00 (AccountingMax
## is per month)
#AccountingStart month 3 15:00

## Contact info to be published in the directory, so we can contact you
## if your relay is misconfigured or something else goes wrong. Google
## indexes this, so spammers might also collect it.
#ContactInfo Random Person <nobody AT example dot com>
## You might also include your PGP or GPG fingerprint if you have one:
#ContactInfo 0xFFFFFFFF Random Person <nobody AT example dot com>

## Uncomment this to mirror directory information for others. Please do
## if you have enough bandwidth.
#DirPort 9030 # what port to advertise for directory connections
## If you want to listen on a port other than the one advertised in
## DirPort (e.g. to advertise 80 but bind to 9091), you can do it as
## follows.  below too. You'll need to do ipchains or other port
## forwarding yourself to make this work.
#DirPort 80 NoListen
#DirPort 127.0.0.1:9091 NoAdvertise
## Uncomment to return an arbitrary blob of html on your DirPort. Now you
## can explain what Tor is if anybody wonders why your IP address is
## contacting them. See contrib/tor-exit-notice.html in Tor's source
## distribution for a sample.
#DirPortFrontPage /etc/tor/tor-exit-notice.html

## Uncomment this if you run more than one Tor relay, and add the identity
## key fingerprint of each Tor relay you control, even if they're on
## different networks. You declare it here so Tor clients can avoid
## using more than one of your relays in a single circuit. See
## https://www.torproject.org/docs/faq#MultipleRelays
## However, you should never include a bridge's fingerprint here, as it would
## break its concealability and potentionally reveal its IP/TCP address.
#MyFamily $keyid,$keyid,...

## A comma-separated list of exit policies. They're considered first
## to last, and the first match wins. If you want to _replace_
## the default exit policy, end this with either a reject *:* or an
## accept *:*. Otherwise, you're _augmenting_ (prepending to) the
## default exit policy. Leave commented to just use the default, which is
## described in the man page or at
## https://www.torproject.org/documentation.html
##
## Look at https://www.torproject.org/faq-abuse.html#TypicalAbuses
## for issues you might encounter if you use the default exit policy.
##
## If certain IPs and ports are blocked externally, e.g. by your firewall,
## you should update your exit policy to reflect this -- otherwise Tor
## users will be told that those destinations are down.
##
## For security, by default Tor rejects connections to private (local)
## networks, including to your public IP address. See the man page entry
## for ExitPolicyRejectPrivate if you want to allow \"exit enclaving\".
##
#ExitPolicy accept *:6660-6667,reject *:* # allow irc ports but no more
#ExitPolicy accept *:119 # accept nntp as well as default exit policy
#ExitPolicy reject *:* # no exits allowed

## Bridge relays (or \"bridges\") are Tor relays that aren't listed in the
## main directory. Since there is no complete public list of them, even an
## ISP that filters connections to all the known Tor relays probably
## won't be able to block all the bridges. Also, websites won't treat you
## differently because they won't know you're running Tor. If you can
## be a real relay, please do; but if not, be a bridge!
#BridgeRelay 1
## By default, Tor will advertise your bridge to users through various
## mechanisms like https://bridges.torproject.org/. If you want to run
## a private bridge, for example because you'll give out your bridge
## address manually to your friends, uncomment this line:
#PublishServerDescriptor 0

LongLivedPorts 80,443,23,21,22,706,1863,5050,5190,5222,5223,6667,8300,8888

bridge 185.9.49.178:443
bridge 54.251.69.3:443
bridge 83.212.96.134:443
bridge 46.20.242.51:80
bridge 176.56.230.149:443
Bridge 46.20.242.51:80
Bridge 83.212.96.134:443
Bridge 175.56.230.149:443
bridge obfs3 54.229.88.196:40872  
bridge obfs3 54.253.11.234:40872  
bridge obfs3 54.234.217.137:40872  
bridge obfs3 172.245.62.183:56921  
bridge obfs3 54.251.69.3:40872  
bridge obfs3 54.244.67.22:40872  
bridge obfs3 54.224.22.183:40872 
bridge obfs2 83.255.50.55:40191  
bridge obfs2 175.41.179.84:52176  
bridge obfs2 54.247.15.21:52176 
bridge obfs2 54.251.69.3:52176  
bridge obfs2 83.212.96.134:56707  
bridge obfs2 54.244.67.22:52176  
bridge obfs2 38.229.33.18:42401
bridge obfs2 85.17.20.242:61264
bridge obfs2 85.214.131.213:1051
bridge obfs2 86.59.30.35:45605
bridge obfs2 91.208.34.7:5353
bridge obfs2 109.105.109.163:53999
bridge obfs2 109.163.233.195:1051
bridge obfs2 128.31.0.34:1051
bridge obfs2 131.215.158.1:29936
bridge obfs2 173.254.192.38:1051
bridge obfs2 188.40.20.215:32982
bridge obfs2 212.112.242.160:49259
bridge obfs2 213.108.105.129:36609
bridge obfs2 59.152.223.206:9002
bridge obfs2 38.229.33.18:42401
bridge obfs2 38.229.33.18:42401
bridge obfs2 85.214.131.213:1051
bridge obfs2 86.59.30.35:45605
bridge obfs2 91.208.34.7:5353
bridge obfs2 109.105.109.163:53999
bridge obfs2 109.163.233.195:1051
bridge obfs2 128.30.30.25:51420
bridge obfs2 128.31.0.34:1051
bridge obfs2 131.215.158.1:29936
bridge obfs2 173.254.192.38:1051
bridge obfs2 188.40.20.215:32982
bridge obfs2 212.112.242.160:49259
bridge obfs2 213.108.105.129:36609
bridge obfs2 38.229.33.18:42401
Bridge obfs2 83.212.100.216:47870
bridge obfs2 38.229.33.18:42401
bridge obfs2 85.214.131.213:1051
bridge obfs2 38.229.33.18:42401
bridge obfs2 85.214.131.213:1051
bridge obfs2 109.105.109.163:53999
Bridge obfs2  4.248.139.214:52176
Bridge obfs2 128.31.0.34:1051
bridge obfs2 38.229.33.18:42401
bridge obfs2 38.229.33.18:42401
Bridge obfs2 128.31.0.34:1051
Bridge obfs2 192.0.2.4:5555
Bridge obfs2 109.105.109.163:46924
Bridge obfs2 128.31.0.34:1051
Bridge obfs2 109.105.109.163:46924
Bridge obfs2 83.212.96.182:46602
bridge obfs2 85.214.131.213:1051
Bridge obfs2 128.31.0.34:1051
Bridge obfs2 83.212.100.216:47870
Bridge obfs2 83.212.96.182:46602
Bridge obfs2 109.105.109.163:46924
bridge obfs2 141.201.27.48:420
bridge obfs2 38.229.33.18:42401
bridge obfs2 192.0.2.198:58854
bridge obfs2 38.229.33.18:42401
bridge obfs2 96.47.67.233:12984  
bridge obfs2 54.247.0.43:52176
Bridge obfs2 109.163.233.198:1051
Bridge obfs2 83.212.100.216:47870
Bridge obfs2 83.212.96.182:46602
Bridge obfs2 109.105.109.163:46924
Bridge obfs2 70.182.182.109:54542
Bridge obfs2 169.229.59.74:32779
Bridge obfs2 169.229.59.75:47809
Bridge obfs2 209.141.36.236:60783
Bridge obfs2 208.79.90.242:55564
Bridge obfs2 128.31.0.34:1051

# Enable bridge relay
UseBridges 1
ClientTransportPlugin obfs2,obfs3 exec /usr/local/bin/obfsproxy --managed
" > /etc/tor/torrc

/etc/init.d/tor stop
/etc/init.d/tor start
