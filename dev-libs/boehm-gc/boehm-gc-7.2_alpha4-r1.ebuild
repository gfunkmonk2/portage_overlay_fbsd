# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boehm-gc/boehm-gc-7.2_alpha4-r1.ebuild,v 1.2 2011/11/13 18:56:12 vapier Exp $

inherit eutils

MY_P="gc-${PV/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="http://www.hpl.hp.com/personal/Hans_Boehm/gc/"
SRC_URI="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cxx threads"

DEPEND="dev-libs/libatomic_ops"
RDEPEND="${DEPEND}"

src_compile() {
	sed '/Cflags/s:$:/gc:g' -i bdw-gc.pc.in || die

	econf \
		--with-libatomic-ops=yes \
		$(use_enable cxx cplusplus) \
		$(use threads || echo --disable-threads)
	emake || die
}

src_install() {
	fperms 755 install-sh
	emake DESTDIR="${D}" install || die

	rm -rf "${D}"/usr/share/gc || die

	# dist_noinst_HEADERS
	insinto /usr/include/gc
	doins include/{cord.h,ec.h,javaxfc.h}
	insinto /usr/include/gc/private
	doins include/private/*.h

	dodoc README.QUICK doc/README* doc/barrett_diagram
	dohtml doc/*.html
	newman doc/gc.man GC_malloc.1
}
