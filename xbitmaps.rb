class Xbitmaps < Formula
  desc "Bitmap images used by multiple applications"
  homepage "https://xcb.freedesktop.org"
  url "https://xorg.freedesktop.org/archive/individual/data/xbitmaps-1.1.1.tar.bz2"
  sha256 "3671b034356bbc4d32d052808cf646c940ec8b2d1913adac51b1453e41aa1e9d"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "0503b8236d72b909e51a9b6e3628de267b479597d06ca893b202ced7943523f4" => :x86_64_linux
  end

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
    system "make", "install"
  end
end
