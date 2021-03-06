class FontDecMisc < Formula
  desc "X.Org Fonts: font dec misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-dec-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-dec-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-dec-misc-1.0.3.tar.bz2"
  sha256 "e19ddf8b5f8de914d81675358fdfe37762e9ce524887cc983adef34f2850ff7b"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "89218bea462ffd7dbdd4d81642856d8c768ff729eec26d8188a60cd791f80185" => :x86_64_linux
  end

  keg_only "part of Xorg-fonts package"

  depends_on "bzip2" => [:build, :recommended]
  depends_on "fontconfig" => :build
  depends_on "linuxbrew/xorg/bdftopcf" => :build
  depends_on "linuxbrew/xorg/font-util" => :build
  depends_on "linuxbrew/xorg/mkfontscale" => :build
  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-fontrootdir=#{share}/fonts/X11
    ]
    args << "--with-compression=bzip2" if build.with? "bzip2"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
