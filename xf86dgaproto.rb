class Xf86dgaproto < Formula
  desc "X.Org Protocol Headers: xf86dgaproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/xf86dgaproto-2.1.tar.bz2"
  sha256 "ac5ef65108e1f2146286e53080975683dae49fc94680042e04bd1e2010e99050"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "4aeae3f4c030ecc0e0abdb4b66895f8bf569337c580637fc9c013c5894588f01" => :x86_64_linux
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
