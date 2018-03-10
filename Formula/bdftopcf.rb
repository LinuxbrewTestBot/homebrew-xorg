class Bdftopcf < Formula
  desc "X.Org Applications: bdftopcf"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/bdftopcf-1.0.5.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/bdftopcf-1.0.5.tar.bz2"
  sha256 "38f447be0c61f94c473f128cf519dd0cff63b5d7775240a2e895a183a61e2026"
  # tag "linuxbrew"

  bottle do
    rebuild 1
    sha256 "c989212a6bbb2e06b7fbde52f1353edbb735ad6ef7d78aaf6f198d8577195cc7" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros"=> :build
  depends_on "linuxbrew/xorg/libxfont"
  depends_on "linuxbrew/xorg/fontsproto"
  depends_on "linuxbrew/xorg/xproto"
  depends_on "bzip2"

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
