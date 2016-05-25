# font-adobe-utopia-100dpi: Build a bottle for Linuxbrew
class FontAdobeUtopia100dpi < Formula
  desc "X.Org Fonts: font adobe utopia 100dpi"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-adobe-utopia-100dpi-1.0.4.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-adobe-utopia-100dpi-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-adobe-utopia-100dpi-1.0.4.tar.bz2"
  sha256 "d16f5e3f227cc6dd07a160a71f443559682dbc35f1c056a5385085aaec4fada5"
  # tag "linuxbrew"

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
    ]
    args << "--with-compression=bzip2" if build.with?("bzip2")

    system "./configure", *args
    system "make"
    system "make", "install"

    prefix.install "README" => "font-adobe-utopia-100dpi.md"
  end
end
