#!/bin/sh
set -e
sudo yum -y groupinstall "Development Tools"
sudo dnf install -y \
    boost-build \
    boost-devel \
    openssl-devel \
    qt5-devel \
    qt5-qtbase-devel \
    qt5-linguist

wget https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_1_13/libtorrent-rasterbar-1.1.13.tar.gz
tar -zxf libtorrent-rasterbar-1.1.13.tar.gz
cd libtorrent-rasterbar-1.1.13
./configure --prefix=/usr CXXFLAGS=-std=c++11
make
sudo make install
sudo ln -s /usr/lib/pkgconfig/libtorrent-rasterbar.pc /usr/lib64/pkgconfig/libtorrent-rasterbar.pc
sudo ln -s /usr/lib/libtorrent-rasterbar.so.9 /usr/lib64/libtorrent-rasterbar.so.9
Install qBittorrent
wget https://sourceforge.net/projects/qbittorrent/files/qbittorrent/qbittorrent-4.1.9.1/qbittorrent-4.1.9.1.tar.gz
tar -zxf qbittorrent-4.1.9.1.tar.gz
cd qbittorrent-4.1.9.1
./configure
make
sudo make install
mkdir -p ~/.config/qBittorrent
cat > ~/.config/qBittorrent/qBittorrent.conf <<- EOM
[Preferences]
WebUI\Enabled=true
EOM
