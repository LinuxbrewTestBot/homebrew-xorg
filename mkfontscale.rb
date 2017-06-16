class Mkfontscale < Formula
  desc "X.Org Applications: mkfontscale"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/mkfontscale-1.1.2.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/mkfontscale-1.1.2.tar.bz2"
  sha256 "8c6d5228af885477b9aec60ca6f172578e7d2de42234357af62fb00439453f20"
  # tag "linuxbrew"

  bottle do
    rebuild 1
    sha256 "127d9c9c19ff8498f1bc4b1a5d548c8c2a7071591d852b518046b7b1f1b53b14" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libfontenc"
  depends_on "freetype"
  depends_on "bzip2" => :recommended
  depends_on "linuxbrew/xorg/xproto" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--with-bzip2" if build.with?("bzip2")

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
