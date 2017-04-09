class Mkfontdir < Formula
  desc "X.Org Applications: mkfontdir"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/mkfontdir-1.0.7.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/mkfontdir-1.0.7.tar.bz2"
  sha256 "56d52a482df130484e51fd066d1b6eda7c2c02ddbc91fe6e2be1b9c4e7306530"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "fcb3c9764623371d80104b30d8601b483366f50e8dd10e613631d7121146b495" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/mkfontscale" => :run

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
