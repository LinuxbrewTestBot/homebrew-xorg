class Videoproto < Formula
  desc "X.Org Protocol Headers: videoproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/videoproto-2.3.3.tar.bz2"
  sha256 "c7803889fd08e6fcaf7b68cc394fb038b2325d1f315e571a6954577e07cca702"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "e09b75b792265c38319f3ce32de9a7460bc908e237b6c4e67e163c97b4af2731" => :x86_64_linux
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
