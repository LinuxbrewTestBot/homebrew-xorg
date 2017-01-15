class Dri3proto < Formula
  desc "X.Org Protocol Headers: dri3proto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/dri3proto-1.0.tar.bz2"
  sha256 "01be49d70200518b9a6b297131f6cc71f4ea2de17436896af153226a774fc074"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "a0a6c7c1c97a8a70635b8c085c60ee16776904c2d197d0630e8d3bbf988df156" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

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
