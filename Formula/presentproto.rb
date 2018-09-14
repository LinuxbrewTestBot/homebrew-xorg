class Presentproto < Formula
  desc "X.Org Protocol Headers: presentproto"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/presentproto-1.1.tar.bz2"
  sha256 "f69b23a8869f78a5898aaf53938b829c8165e597cda34f06024d43ee1e6d26b9"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "b4b4ed865313ccc6bad7fc0b4ed7b3259c9ff72fdc301637d3c60a806ce6443b" => :x86_64_linux
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
