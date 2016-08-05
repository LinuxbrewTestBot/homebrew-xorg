class FontXfree86Type1 < Formula
  desc "X.Org Fonts: font xfree86 type1"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-xfree86-type1-1.0.4.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-xfree86-type1-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-xfree86-type1-1.0.4.tar.bz2"
  sha256 "caebf42aec7be7f3bd40e0f232d6f34881b853dc84acfcdf7458358701fbe34a"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "560c0596d979274706f85f856203e6058677d1a82c8890b746ad21e2c1b3c8da" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" =>  :build
  depends_on "font-util"  =>  :build
  depends_on "bdftopcf"   =>  :build
  depends_on "mkfontdir"  =>  :build
  depends_on "fontconfig" =>  :build

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
