# xsetroot: Build a bottle for Linuxbrew (again)
class Xsetroot < Formula
  desc "X.Org Applications: xsetroot"
  homepage "http://www.x.org/"
  bottle do
    cellar :any_skip_relocation
    sha256 "79a6e85d103713f0b4c5d3d4cd8030a97a4bbd0a285c6d1a648ac99147ea30b2" => :x86_64_linux
  end

  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xsetroot-1.1.1.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xsetroot-1.1.1.tar.bz2"
  sha256 "ba215daaa78c415fce11b9e58c365d03bb602eaa5ea916578d76861a468cc3d9"
  # tag "linuxbrew"

  #xmuu x11 xbitmaps xcursor xproto
  depends_on "pkg-config" =>  :build
  depends_on "xproto" => :build
  depends_on "util-macros" => :build
  depends_on "libx11"
  depends_on "libxmu"
  depends_on "xbitmaps"
  depends_on "libxcursor"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
