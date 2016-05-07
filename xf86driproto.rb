# xf86driproto: Build a bottle for Linuxbrew
class Xf86driproto < Formula
  desc "X.Org Protocol Headers: xf86driproto"
  bottle do
    cellar :any_skip_relocation
    sha256 "add3e319e6aa797042f7b8eb8ca39b9213fdc642330769cd80f1656b007be6fa" => :x86_64_linux
  end

  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/xf86driproto-2.1.1.tar.bz2"
  sha256 "9c4b8d7221cb6dc4309269ccc008a22753698ae9245a398a59df35f1404d661f"
  # tag "linuxbrew"

  depends_on "pkg-config"         =>  :build
  depends_on "util-macros"        =>  :build

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
