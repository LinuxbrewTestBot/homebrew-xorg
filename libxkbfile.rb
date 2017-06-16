class Libxkbfile < Formula
  desc "X.Org Libraries: libxkbfile"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libxkbfile-1.0.9.tar.bz2"
  sha256 "51817e0530961975d9513b773960b4edd275f7d5c72293d5a151ed4f42aeb16a"
  # tag "linuxbrew"

  bottle do
    rebuild 1
    sha256 "6c3c2fc05e1195febe3b5e8b0905a660187b0decea7b4781f9d5df070e73276c" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/kbproto" => :build

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
