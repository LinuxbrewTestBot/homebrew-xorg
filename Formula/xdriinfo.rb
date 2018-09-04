class Xdriinfo < Formula
  desc "X.Org Applications: xdriinfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xdriinfo-1.0.6.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xdriinfo-1.0.5.tar.bz2"
  sha256 "d9ccd2c3e87899417acc9ea1f3e319a4198112babe1dc711273584f607449d51"
  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "680bea023686a32b12077bc0c18b64875364bdbe08ee11c63b529fcf8a3b4a22" => :x86_64_linux
  end

  # tag "linuxbrew"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/glproto" => :build
  depends_on "linuxbrew/xorg/kbproto" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/mesa"

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
