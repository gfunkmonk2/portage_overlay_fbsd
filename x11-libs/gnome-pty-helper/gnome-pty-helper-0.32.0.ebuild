# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gnome-pty-helper/gnome-pty-helper-0.32.0.ebuild,v 1.2 2012/04/14 09:11:58 zmedico Exp $

EAPI="4"
GNOME_ORG_MODULE="vte"

inherit gnome.org
inherit eutils

DESCRIPTION="GNOME Setuid helper for opening ptys"
HOMEPAGE="http://git.gnome.org/browse/vte/"
# gnome-pty-helper is inside vte

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="+hardened"

# gnome-pty-helper was spit out with 0.27.90
RDEPEND="!<x11-libs/vte-0.27.90"
DEPEND=""

S="${WORKDIR}/vte-${PV}/gnome-pty-helper"

src_unpack() {
    unpack ${A}
    cd "${S}"
    epatch "${FILESDIR}/patch-gnome-pty-helper_config.h.in.patch"
    epatch "${FILESDIR}/patch-gnome-pty-helper_configure.patch"
    epatch "${FILESDIR}/patch-gnome-pty-helper_gnome-utmp.c.patch"
    epatch "${FILESDIR}/patch-gnome-pty-helper_gnome-pty-helper.c.patch"
}

pkg_setup() {
	# As recommended by upstream (/usr/libexec/$PN is a setgid binary)
	if use hardened; then
		export SUID_CFLAGS="-fPIE ${SUID_CFLAGS}"
		export SUID_LDFLAGS="-pie ${SUID_LDFLAGS}"
	fi
}

