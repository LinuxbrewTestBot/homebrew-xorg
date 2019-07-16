class Libxxf86dga < Formula
  desc "X.Org Libraries: libXxf86dga"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXxf86dga-1.1.5.tar.bz2"
  sha256 "2b98bc5f506c6140d4eddd3990842d30f5dae733b64f198a504f07461bdb7203"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "7c534e6668fcbf09d124c89f32a292fe0e9edc4a650ec69daf8a4aad08d92b6c" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
