class Libxcb < Formula
  desc "An interface to the X Window System protocol, which replaces the current Xlib interface"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://xcb.freedesktop.org/dist/libxcb-1.11.1.tar.bz2"
  sha256 "b720fd6c7d200e5371affdb3f049cc8f88cff9aed942ff1b824d95eedbf69d30"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "c98583d417e9e8c4981ddf27b9088e4abb10c85c82afa215b1600f27642cecd1" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-docs",   "Generate API documentation"

  depends_on "pkg-config" => :build
  depends_on "libxau"
  depends_on "xcb-proto" => :build
  depends_on "libpthread-stubs" => :build
  depends_on "libxdmcp" => :recommended

  depends_on "doxygen" => :build if build.without?("docs")
  depends_on "check" => :build if build.with?("test")
  depends_on "libxslt" => [:build, :optional]

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --enable-xinput
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"
    args << "--enable-devel-docs=#{build.with?("docs") ? "yes" : "no"}"
    args << "--with-doxygen=#{build.with?("docs") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
