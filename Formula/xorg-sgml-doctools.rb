class XorgSgmlDoctools < Formula
  desc "X.Org SGML DocTools"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/doc/xorg-sgml-doctools-1.11.tar.gz"
  sha256 "986326d7b4dd2ad298f61d8d41fe3929ac6191c6000d6d7e47a8ffc0c34e7426"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "5291a341a2068ff32543e99f48c460c9c42408a6394256a88a471c3878f20f9d" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/util-macros"=> :build

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
