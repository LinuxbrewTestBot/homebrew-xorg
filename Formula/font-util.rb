class FontUtil < Formula
  desc "X.Org font package creation/installation utilities"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-util-1.3.2.tar.bz2"
  sha256 "3ad880444123ac06a7238546fa38a2a6ad7f7e0cc3614de7e103863616522282"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "5f737cf1aea100cf66c00499aa98579660a70b018391c8c0509704cb5c0d0e1c" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => :build

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
    system "make", "check" if build.with? "test"
    system "make", "install"
  end

  def post_install
    dirs = %w[encodings 75dpi 100dpi misc]
    dirs.each do |d|
      mkdir_p share/"fonts/X11/#{d}"
    end
  end
end
