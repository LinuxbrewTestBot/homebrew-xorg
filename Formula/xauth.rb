class Xauth < Formula
  desc "X.Org Applications: xauth"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xauth-1.1.tar.bz2"
  sha256 "6d1dd1b79dd185107c5b0fdd22d1d791ad749ad6e288d0cdf80964c4ffa7530c"
  bottle do
    cellar :any_skip_relocation
    sha256 "301ed18d9ec3593f9e231faa78d67b47b101126832199f64a1e0f487de8f5323" => :x86_64_linux
  end

  # tag "linuxbrew"

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => :build
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
