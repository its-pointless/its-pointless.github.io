#!/data/data/com.termux/files/usr/bin/sh
# Get some needed tools. coreutils for mkdir command, gnugp for the signing key, and apt-transport-https to actually connect to the repo
apt-get update
apt-get --assume-yes upgrade
apt-get --assume-yes install coreutils gnupg
# Make the sources.list.d directory
mkdir -p $PREFIX/etc/apt/sources.list.d
# Write the needed source file
if apt-cache policy | grep -q "termux.*24\|termux.org\|bintray.*24\|k51qzi5uqu5dg9vawh923wejqffxiu9bhqlze5f508msk0h7ylpac27fdgaskx" ; then
echo "deb https://its-pointless.github.io/files/24 termux extras" > $PREFIX/etc/apt/sources.list.d/pointless.list
else
echo "deb https://its-pointless.github.io/files/21 termux extras" > $PREFIX/etc/apt/sources.list.d/pointless.list
fi
# Add signing key from https://its-pointless.github.io/pointless.gpg
mkdir -p $PREFIX/etc/apt/trusted.gpg.d
if [ -n $(command -v curl) ]; then
curl -sL https://its-pointless.github.io/pointless.gpg | gpg --dearmor - > $PREFIX/etc/apt/trusted.gpg.d/pointless.gpg
elif [ -n $(command -v wget) ]; then
wget -qO - https://its-pointless.github.io/pointless.gpg | gpg --dearmor - > $PREFIX/etc/apt/trusted.gpg.d/pointless.gpg
fi
# Update apt
apt update
