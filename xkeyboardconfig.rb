class Xkeyboardconfig < Formula
  desc "Keyboard configuration database for the X Window System"
  homepage "https://xorg.freedesktop.org"
  url "https://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-2.20.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.20.tar.bz2"
  sha256 "d1bfc72553c4e3ef1cd6f13eec0488cf940498b612ab8a0b362e7090c94bc134"

  bottle do
    cellar :any_skip_relocation
    sha256 "bad3456766fe1c4dfb31e00cac9d249d1da3f3949d30e129b9abfb369548d1e9" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "linuxbrew/xorg/libx11"

  def install
    # Standard XORG_CONFIG flags
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--with-xkb-rules-symlink=xorg"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
