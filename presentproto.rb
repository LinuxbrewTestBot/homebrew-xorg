# presentproto: Build a bottle for Linuxbrew
class Presentproto < Formula
  desc "X.Org Protocol Headers: presentproto"
  bottle do
    cellar :any_skip_relocation
    sha256 "1681a30944a66c9859275787f978fd12a6b2e8e7015b3008612c0c78e5a9b305" => :x86_64_linux
  end

  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/presentproto-1.0.tar.bz2"
  sha256 "812c7d48721f909a0f7a2cb1e91f6eead76159a36c4712f4579ca587552839ce"
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
