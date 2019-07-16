class Encodings < Formula
  desc "X.Org Fonts: encodings"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/encodings-1.0.5.tar.bz2"
  sha256 "bd96e16143a044b19e87f217cf6a3763a70c561d1076aad6f6d862ec41774a31"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "f5ca6c1bf0a950767738f094978f74ea39690fb773ff612acdec7aade8ee2b73" => :x86_64_linux
  end

  keg_only "part of Xorg-fonts package"

  depends_on "linuxbrew/xorg/font-util" => :build
  depends_on "linuxbrew/xorg/mkfontscale" => :build
  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-fontrootdir=#{share}/fonts/X11
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  # def post_install
  #   (Formula["font-util"].share/"fonts/X11/encodings").install_symlink Dir[share/"fonts/X11/encodings/*"].select { |f| "fonts.dir" != f }
  # end
end
