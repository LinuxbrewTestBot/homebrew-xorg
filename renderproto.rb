class Renderproto < Formula
  desc "X.Org Protocol Headers: renderproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/renderproto-0.11.1.tar.bz2"
  sha256 "06735a5b92b20759204e4751ecd6064a2ad8a6246bb65b3078b862a00def2537"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "f41b3e7d08fd9f273ce6d7a018cbad3c98cc5f08f748371f3927d9b30fe14c76" => :x86_64_linux
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
