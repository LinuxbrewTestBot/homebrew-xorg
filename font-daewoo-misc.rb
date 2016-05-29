# font-daewoo-misc: Build a bottle for Linuxbrew
class FontDaewooMisc < Formula
  desc "X.Org Fonts: font daewoo misc"
  homepage "http://www.x.org/"
  bottle do
    sha256 "0d99d58f44256f08785841a8e4e12ec64df5c35abd74ca9e6dcf054293b2390e" => :x86_64_linux
  end

  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-daewoo-misc-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-daewoo-misc-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-daewoo-misc-1.0.3.tar.bz2"
  sha256 "bc65de70bee12698caa95b523d3b652c056347e17b68cc8b5d6bbdff235c4be8"
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

    prefix.install "README" => "font-daewoo-misc.md"
  end
end
