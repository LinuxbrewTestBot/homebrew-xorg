# xwd: Build a bottle for Linuxbrew
class Xwd < Formula
  desc "X.Org Applications: xwd"
  homepage "http://www.x.org/"
  bottle do
    cellar :any_skip_relocation
    sha256 "c7fb19fb47fe77f00f1e11950c0f2da90d13f148cc984c3718683470fd29f644" => :x86_64_linux
  end

  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xwd-1.0.6.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xwd-1.0.6.tar.bz2"
  sha256 "3bb396a2268d78de4b1c3e5237a85f7849d3434e87b3cd1f4d57eef614227d79"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "xproto" => :build
  depends_on "libx11"
  depends_on "libxkbfile"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xkb
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
