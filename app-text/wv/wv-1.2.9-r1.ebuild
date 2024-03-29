# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv/wv-1.2.9-r1.ebuild,v 1.11 2012/05/04 03:33:14 jdhore Exp $

EAPI="3"

inherit eutils autotools

DESCRIPTION="Tool for conversion of MSWord doc and rtf files to something readable"
SRC_URI="http://abiword.org/downloads/${PN}/${PV}/${P}.tar.gz"
HOMEPAGE="http://wvware.sourceforge.net/"

IUSE="tools wmf"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-solaris"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2
	>=gnome-extra/libgsf-1.13
	sys-libs/zlib
	media-libs/libpng
	dev-libs/libxml2
	tools? ( app-text/texlive-core
		 dev-texlive/texlive-latex )
	wmf? ( >=media-libs/libwmf-0.2.2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	if ! use tools; then
		sed -i -e '/bin_/d' GNUmakefile.am || die
		sed -i -e '/SUBDIRS/d' GNUmakefile.am || die
		sed -i -e '/\/GNUmakefile/d' configure.ac || die
		sed -i -e '/wv[[:upper:]]/d' configure.ac || die
		eautoreconf
	fi
	epatch "${FILESDIR}/patch-config.h.in"
}

src_configure() {
	econf $(use_with wmf libwmf)
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libwv-1.2.so.3
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libwv-1.2.so.3
}

src_install () {
	mkdir ${W}/image/usr/
	mkdir ${W}/image/usr/share
	mkdir ${W}/image/usr/share/wv

	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc README NEWS || die

	rm -f "${ED}"/usr/share/man/man1/wvConvert.1
	if use tools; then
		dosym  /usr/share/man/man1/wvWare.1 /usr/share/man/man1/wvConvert.1 || die
	fi
}
