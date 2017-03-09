class Xineramaproto < Formula
  desc "X.Org Protocol Headers: xineramaproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/xineramaproto-1.2.1.tar.bz2"
  sha256 "977574bb3dc192ecd9c55f59f991ec1dff340be3e31392c95deff423da52485b"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "e514c07a38aff99ed9a02e7242809a3ae95159ce36bfbd07a1ac32a775d3214a" => :x86_64_linux
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
