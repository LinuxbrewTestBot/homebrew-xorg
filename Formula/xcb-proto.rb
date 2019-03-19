class XcbProto < Formula
  desc "XML-XCB protocol descriptions that libxcb uses for code generation"
  homepage "https://www.x.org/"
  url "https://xcb.freedesktop.org/dist/xcb-proto-1.13.tar.bz2"
  sha256 "7b98721e669be80284e9bbfeab02d2d0d54cd11172b72271e47a2fe875e2bde1"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "fce6269bcc4603798c4f76e87d4445feaf849da60c0e115b1e50db0acc0c529e" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    # Remove xcbgen so that xcb-proto does not need to depend on Python
    inreplace "Makefile.am", "SUBDIRS = src xcbgen", "SUBDIRS = src"
    inreplace "Makefile.in", "SUBDIRS = src xcbgen", "SUBDIRS = src"
    inreplace "configure.ac", "AC_OUTPUT([Makefile src/Makefile xcbgen/Makefile xcb-proto.pc])", "AC_OUTPUT([Makefile src/Makefile xcb-proto.pc])"

    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
    ]

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
