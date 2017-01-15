class Fixesproto < Formula
  desc "X.Org Protocol Headers: fixesproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/fixesproto-5.0.tar.bz2"
  sha256 "ba2f3f31246bdd3f2a0acf8bd3b09ba99cab965c7fb2c2c92b7dc72870e424ce"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "8a53f8e2e2151148539e4015c923c76d8c2fd3946e0480578f3ed8e28b579eac" => :x86_64_linux
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
