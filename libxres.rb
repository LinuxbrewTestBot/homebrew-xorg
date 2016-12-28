class Libxres < Formula
  desc "X.Org Libraries: libXres"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXres-1.0.7.tar.bz2"
  sha256 "26899054aa87f81b17becc68e8645b240f140464cf90c42616ebb263ec5fa0e5"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "3e5cf0e33f11bb7281094a3a13500022bef903df3f7ff429034a1c9a671ab614" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "libx11"
  depends_on "libxext"
  depends_on "xextproto" => :build
  depends_on "resourceproto" => :build

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
