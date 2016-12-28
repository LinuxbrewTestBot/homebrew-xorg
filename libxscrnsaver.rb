class Libxscrnsaver < Formula
  desc "X.Org Libraries: libXScrnSaver"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXScrnSaver-1.2.2.tar.bz2"
  sha256 "8ff1efa7341c7f34bcf9b17c89648d6325ddaae22e3904e091794e0b4426ce1d"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "8bfadd149045b5ad993d987bbab6ca18aea5ca3d497c397511a88bb5248b7299" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "libx11"
  depends_on "libxext"
  depends_on "xextproto" => :build
  depends_on "scrnsaverproto" => :build

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
