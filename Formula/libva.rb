class Libva < Formula
  desc "Hardware accelerated video processing library"
  homepage "https://freedesktop.org/wiki/Software/vaapi/"
  url "https://www.freedesktop.org/software/vaapi/releases/libva/libva-1.7.3.tar.bz2"
  sha256 "22bc139498065a7950d966dbdb000cad04905cbd3dc8f3541f80d36c4670b9d9"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    rebuild 1
    sha256 "06953219e65a983e58fe1906f4ba6fa476ce70529354bbfd268c70663258b64a" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"

  # Trivia: there is a circular dependency with Mesa.
  # Libva has to be installed:
  #  1. before Mesa >> with "disable-egl" and "disable-glx" options >> this package
  #  2. after  Mesa >> without these options
  # Step #2 is hard-coded into mesa (if built with [default] `with-libva`) as a post-installation step
  # Step #2 can be invoked manually here by specifying `with-eglx`

  option "with-eglx", "Build libva with egl and glx support (use after building mesa)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/wayland" => :recommended

  if build.without? "wayland"
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  depends_on "linuxbrew/xorg/libdrm"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxfixes"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{prefix}/etc
      --localstatedir=#{prefix}/var
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    if build.without? "eglx"
      args << "--disable-egl"
      args << "--disable-glx"
    end

    system "autoreconf", "-fi" if build.without? "wayland"
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
