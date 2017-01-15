class Presentproto < Formula
  desc "X.Org Protocol Headers: presentproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/presentproto-1.0.tar.bz2"
  sha256 "812c7d48721f909a0f7a2cb1e91f6eead76159a36c4712f4579ca587552839ce"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "c343031551fcb220a018c1e90d930b4fbd4128adaf4a009711c1a5568ecaa3c5" => :x86_64_linux
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
