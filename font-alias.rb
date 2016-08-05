class FontAlias < Formula
  desc "X.Org Fonts: font alias"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-alias-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-alias-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-alias-1.0.3.tar.bz2"
  sha256 "8b453b2aae1cfa8090009ca037037b8c5e333550651d5a158b7264ce1d472c9a"
  revision 1
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "f98f47456291d9d9f30a52749981d5156e672e7be5226b5a6e2dcc36d8a9262a" => :x86_64_linux
  end

  depends_on "pkg-config" =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-fontrootdir=#{share}/fonts/X11
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
