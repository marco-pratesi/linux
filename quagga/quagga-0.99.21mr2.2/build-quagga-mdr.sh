#!/bin/bash

SUFFIX=-mdr
PREFIX=/usr/local/quagga$SUFFIX
LOCALESTATEDIR=/var/run/quagga

# Put patches, conf, and init files in the ./misc directory;
# extract quagga-0.99.21mr2.2.tar.gz and olsrd-0.6.5.4.tar.bz2;
# put this script in the quagga-0.99.21mr2.2 directory;
# cd quagga-0.99.21mr2.2
# then run this script to build and install quagga-0.99.21mr2.2.

# Some packages may need to be installed to successfully build the package:
# on Ubuntu 12.04.x, gawk, libreadline6-dev, libpam0g-dev, and maybe others;
# install them through either the apt-get command or a GUI package manager,
# to automatically resolve dependencies.

patch -p1 < ../misc/quagga-0.99.21mr2.2-zebra-libcap.patch
patch -p1 < ../olsrd-0.6.5.4/lib/quagga/patches/quagga-0.99.21.diff #HUNK1 fails
patch -p1 < ../misc/olsrd-quagga-0.99.21mr2.2-hunk1.patch

# Similar to the configure command in the Debian/Ubuntu "rules" build file
./configure \
 --prefix=$PREFIX --libexecdir=$PREFIX/sbin --sbindir=$PREFIX/sbin \
 --sysconfdir=$PREFIX/etc --localstatedir=$LOCALESTATEDIR \
 --datarootdir=$PREFIX/share --datadir=$PREFIX/share \
 --enable-exampledir=$PREFIX/share/doc/examples --disable-doc \
 --enable-shared=yes --enable-static=no --enable-fast-install=no \
 --enable-vtysh --enable-watchquagga \
 --enable-ipv6 --enable-rtadv --enable-multipath=64 \
 --disable-bgpd --disable-ripd --disable-ripngd \
 --disable-babeld --disable-isisd \
 --enable-ospf-te --enable-opaque-lsa \
 --enable-ospfclient=yes --enable-ospfapi=yes \
 --enable-user=quagga --enable-group=quagga --enable-vty-group=quaggavty \
 --enable-configfile-mask=0640 --enable-logfile-mask=0640 \
 --with-libpam --enable-gcc-rdynamic

make install
( cd $PREFIX ; strip bin/* sbin/* ; strip --strip-unneeded lib/*.so* )

# Taken from Debian/Ubuntu's quagga.preinst script:
if ! getent group quaggavty > /dev/null; then
 addgroup --system quaggavty > /dev/null
fi
if ! getent group quagga > /dev/null; then
 addgroup --system quagga > /dev/null
fi
if ! getent passwd quagga > /dev/null; then
 adduser --system --ingroup quagga --home $LOCALESTATEDIR \
  --gecos "Quagga routing suite" --shell /bin/false quagga > /dev/null
fi

mkdir -p $LOCALESTATEDIR ; chown quagga. $LOCALESTATEDIR
mkdir -p $PREFIX/init.d
cp ../misc/quagga${SUFFIX}-init_d $PREFIX/init.d/quagga$SUFFIX
chown -R root. $PREFIX/init.d ; chmod -R 755 $PREFIX/init.d

mkdir -p $PREFIX/etc ; chown quagga.quaggavty $PREFIX/etc ; chmod 750 $PREFIX/etc
( cd ../misc ; \
  cp daemons debian.conf zebra.conf ospfd.conf ospf6d.conf $PREFIX/etc )
( cd $PREFIX/etc ; chmod 640 * ; chown quagga. * ; \
  chown quagga.quaggavty daemons debian.conf )

