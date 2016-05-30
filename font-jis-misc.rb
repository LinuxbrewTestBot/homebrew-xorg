# font-jis-misc: Build a bottle for Linuxbrew
class FontJisMisc < Formula
  desc "X.Org Fonts: font jis misc"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-jis-misc-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-jis-misc-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-jis-misc-1.0.3.tar.bz2"
  sha256 "2b18ce10b367ebafe95a17de799b6db9a24e2337188d124adaf68af05b1fac65"
  # tag "linuxbrew"

  bottle do
    revision 1
    sha256 "4175a201310704eebc8ec8877ae6d3c3df0be9c393e44c97432b06b89eb5b463" => :x86_64_linux
  end

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

    prefix.install "README" => "font-jis-misc.md"
  end
end
