class Randrproto < Formula
  desc "X.Org Protocol Headers: randrproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/randrproto-1.5.0.tar.bz2"
  sha256 "4c675533e79cd730997d232c8894b6692174dce58d3e207021b8f860be498468"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "375bacd74cef18af6565d23d8ee2c75fc7b35a390c5f5d3e8bbb414173323175" => :x86_64_linux
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
