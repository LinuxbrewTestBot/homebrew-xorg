class FontJisMisc < Formula
  desc "X.Org Fonts: font jis misc"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-jis-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-jis-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-jis-misc-1.0.3.tar.bz2"
  sha256 "2b18ce10b367ebafe95a17de799b6db9a24e2337188d124adaf68af05b1fac65"
  revision 1
  # tag "linuxbrew"

  bottle do
    revision 1
    sha256 "244b9c5d3b6b1337b90fd9850382194f96b6b38912943da9f16e81099096849c" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" =>  :build
  depends_on "font-util"  =>  :build
  depends_on "bdftopcf"   =>  :build
  depends_on "mkfontdir"  =>  :build
  depends_on "fontconfig" =>  :build
  depends_on "bzip2"      => [:build, :recommended]

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-fontrootdir=#{share}/fonts/X11
    ]
    args << "--with-compression=bzip2" if build.with?("bzip2")

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
