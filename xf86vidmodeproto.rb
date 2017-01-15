class Xf86vidmodeproto < Formula
  desc "X.Org Protocol Headers: xf86vidmodeproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/xf86vidmodeproto-2.3.1.tar.bz2"
  sha256 "45d9499aa7b73203fd6b3505b0259624afed5c16b941bd04fcf123e5de698770"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "cf3298a96264e0df8e966233e82443128b8aecc2b47ecac370c04e2ca66e320f" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make", "install"
  end
end
