class Libdrm < Formula
  desc "libdrm: cross-driver middleware"
  homepage "http://dri.freedesktop.org"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.68.tar.bz2"
  sha256 "5b4bd9a5922929bc716411cb74061fbf31b06ba36feb89bc1358a91a8d0ca9df"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "6ef6de9a587887af2b1f5c7954e64b6d5684213dbd4584c606bc9afe29cbdaa9" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static",   "Build static libraries (not recommended)"
  option "with-valgrind", "Build libdrm with valgrind support"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libpciaccess" => :build
  depends_on "libpthread-stubs" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-udev
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    ENV["ACLOCAL"] = "aclocal -I #{HOMEBREW_PREFIX}/share/aclocal"
    system "autoreconf", "-fiv"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
