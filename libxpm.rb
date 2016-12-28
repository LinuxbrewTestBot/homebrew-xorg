class Libxpm < Formula
  desc "X.Org Libraries: libXpm"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXpm-3.5.11.tar.bz2"
  sha256 "c5bdafa51d1ae30086fac01ab83be8d47fe117b238d3437f8e965434090e041c"
  # tag "linuxbrew"

  bottle do
    rebuild 1
    sha256 "54c4d91e6e46104590563fade088e1333c5c1ea9fe48aa41cd82184d2298ca2d" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "xproto" => :build
  depends_on "libx11"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--disable-static" if build.without?("static")

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
