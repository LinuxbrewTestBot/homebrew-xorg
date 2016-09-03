class Dmxproto < Formula
  desc "X.Org Protocol Headers: dmxproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/dmxproto-2.3.1.tar.bz2"
  sha256 "e72051e6a3e06b236d19eed56368117b745ca1e1a27bdc50fd51aa375bea6509"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "ce3ae51a16c52f077b415ee546587a6f9c55a0f9bc375d8c5db5cfdf5fbb8c07" => :x86_64_linux
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
