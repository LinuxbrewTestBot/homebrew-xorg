class Xauth < Formula
  desc "X.Org Applications: xauth"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xauth-1.0.10.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xauth-1.0.10.tar.bz2"
  sha256 "5afe42ce3cdf4f60520d1658d2b17face45c74050f39af45dccdc95e73fafc4d"
  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "b749de0bb5aa76d426a434852075c79b2adbb02e273b6324b71be95c2106048b" => :x86_64_linux
  end

  # tag "linuxbrew"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/libxmu" # brings in libxext, libx11, libxau

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-unix-transport
      --enable-tcp-transport
      --enable-ipv6
      --enable-local-transport
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
