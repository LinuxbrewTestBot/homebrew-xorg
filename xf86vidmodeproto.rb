# xf86vidmodeproto: Build a bottle for Linuxbrew
class Xf86vidmodeproto < Formula
  desc "X.Org Protocol Headers: xf86vidmodeproto"
  bottle do
    cellar :any_skip_relocation
    sha256 "fcf020ee7ae77f134702e0ae849e7d4211e7db404431ef0a02e6076c66e753cd" => :x86_64_linux
  end

  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/xf86vidmodeproto-2.3.1.tar.bz2"
  sha256 "45d9499aa7b73203fd6b3505b0259624afed5c16b941bd04fcf123e5de698770"
  # tag "linuxbrew"

  depends_on "pkg-config"         =>  :build
  depends_on "util-macros"        =>  :build

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
