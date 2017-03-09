class Xf86driproto < Formula
  desc "X.Org Protocol Headers: xf86driproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/xf86driproto-2.1.1.tar.bz2"
  sha256 "9c4b8d7221cb6dc4309269ccc008a22753698ae9245a398a59df35f1404d661f"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "026e236c1cdc8a1842e046d0a7ef53c5809ec0ffded84fd1ac2c88af05dd13f5" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build

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
