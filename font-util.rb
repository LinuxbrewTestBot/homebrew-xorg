class FontUtil < Formula
  desc "X.Org font package creation/installation utilities"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-util-1.3.1.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-util-1.3.1.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-util-1.3.1.tar.bz2"
  sha256 "aa7ebdb0715106dd255082f2310dbaa2cd7e225957c2a77d719720c7cc92b921"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "de3766d621c2597077cb1671088d99d9589381b5977bec436a430f9166a2a046" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build

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
    system "make", "check" if build.with?("test")
    system "make", "install"
  end

  def post_install
    dirs = ["encodings", "75dpi", "100dpi", "misc"]
    dirs.each do |d|
      mkdir_p share/"fonts/X11/#{d}"
    end
  end
end
