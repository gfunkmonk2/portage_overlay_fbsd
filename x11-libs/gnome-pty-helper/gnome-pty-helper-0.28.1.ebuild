# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gnome-pty-helper/gnome-pty-helper-0.28.1.ebuild,v 1.9 2011/11/22 16:14:40 zmedico Exp $

EAPI="4"
GNOME_ORG_MODULE="vte"
GNOME_TARBALL_SUFFIX="xz"

inherit gnome.org base

DESCRIPTION="GNOME Setuid helper for opening ptys"
HOMEPAGE="http://git.gnome.org/browse/vte/"
# gnome-pty-helper is inside vte

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-linux"
IUSE=""

# gnome-pty-helper was spit out with 0.27.90
RDEPEND="!<x11-libs/vte-0.27.90"
DEPEND=""

S="${WORKDIR}/vte-${PV}/gnome-pty-helper"

src_unpack() {
    unpack ${A}
    cd "${S}"
    epatch "${FILESDIR}"/patch-gnome-pty-helper_config.h.in"
    epatch "${FILESDIR}"/patch-gnome-pty-helper_configure"
    epatch "${FILESDIR}"/patch-gnome-pty-helper_gnome-utmp.c"
    epatch "${FILESDIR}"/patch-gnome-pty-helper_gnome-pty-helper.c"
}
