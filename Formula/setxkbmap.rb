class Setxkbmap < Formula
  desc "X.Org Applications: setxkbmap"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/setxkbmap-1.3.2.tar.bz2"
  sha256 "8ff27486442725e50b02d7049152f51d125ecad71b7ce503cfa09d5d8ceeb9f5"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "670faaa1f50059343cbd4d6411316a7895cb34631ded7fcb9f14d3bddb186cd5" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxkbfile"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xkb-config-root=#{Formula["libx11"].share}/X11/xkb
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
