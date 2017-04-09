class WaylandProtocols < Formula
  desc "Additional Wayland protocols"
  homepage "https://wayland.freedesktop.org"
  url "https://wayland.freedesktop.org/releases/wayland-protocols-1.7.tar.xz"
  sha256 "635f2a937d318f1fecb97b54074ca211486e38af943868dd0fa82ea38d091c1f"

  bottle do
    cellar :any_skip_relocation
    sha256 "bf59b4eb86d2132ab948fe179575c92b1d4f9e2965cb21827f8537e21ca1f929" => :x86_64_linux
  end

  head do
    url "git://anongit.freedesktop.org/wayland/wayland-protocols"
  end

  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/wayland"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
