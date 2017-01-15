class Randrproto < Formula
  desc "X.Org Protocol Headers: randrproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/randrproto-1.5.0.tar.bz2"
  sha256 "4c675533e79cd730997d232c8894b6692174dce58d3e207021b8f860be498468"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "6c804a1030e5609d8af6014dc0787df66fe9baf98fd58093f77698592a869aea" => :x86_64_linux
  end

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
