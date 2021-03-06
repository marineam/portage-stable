# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/u-boot-tools/u-boot-tools-2011.06.ebuild,v 1.2 2011/10/14 22:29:10 vapier Exp $

EAPI=4

inherit toolchain-funcs

MY_P="u-boot-${PV/_/-}"
DESCRIPTION="utilities for working with Das U-Boot"
HOMEPAGE="http://www.denx.de/wiki/U-Boot/WebHome"
SRC_URI="ftp://ftp.denx.de/pub/u-boot/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e "s:-g ::" tools/Makefile || die
}

src_compile() {
	emake \
		HOSTSTRIP=echo \
		HOSTCC="$(tc-getCC)" \
		HOSTCFLAGS="${CFLAGS} ${CPPFLAGS}"' $(HOSTCPPFLAGS)' \
		HOSTLDFLAGS="${LDFLAGS}" \
		tools-all
}

src_install() {
	cd tools
	dobin bmp_logo gen_eth_addr img2srec mkimage
	dobin easylogo/easylogo
	dobin env/fw_printenv
	dosym fw_printenv /usr/bin/fw_setenv
	insinto /etc
	doins env/fw_env.config
}
