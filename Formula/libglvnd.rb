class Libglvnd < Formula
  desc "GL Vendor-Neutral Dispatch library"
  homepage "https://github.com/NVIDIA/libglvnd"
  url "https://github.com/NVIDIA/libglvnd/releases/download/v1.1.1/libglvnd-1.1.1.tar.gz"
  sha256 "71918ed1261e4eece18c0b74b50dc62c0237b8d526e83277ef078554544720b9"
  head "https://github.com/NVIDIA/libglvnd.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "522f5c337791bed31d65096c68b4517ea7548e81f0f798b5e58dcc5cd03cacff" => :x86_64_linux
  end

  option "without-asm", "Build without assembly"
  option "without-tls", "Build without TLS support"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "linuxbrew/xorg/libpthread-stubs" => :build
  depends_on "linuxbrew/xorg/libxext" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "python@2" => :build

  if build.head?
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end
  depends_on "linuxbrew/xorg/libx11"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
      --enable-asm=#{build.with?("asm") ? "yes" : "no"}
      --enable-tls=#{build.with?("tls") ? "yes" : "no"}
    ]

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
