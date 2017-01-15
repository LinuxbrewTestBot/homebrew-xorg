class Compositeproto < Formula
  desc "X.Org Protocol Headers: compositeproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/compositeproto-0.4.2.tar.bz2"
  sha256 "049359f0be0b2b984a8149c966dd04e8c58e6eade2a4a309cf1126635ccd0cfc"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "b3397f6f762bd5395ba0a8b440a878b3700a7bbd4346f8cafa4e841581c2e620" => :x86_64_linux
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
