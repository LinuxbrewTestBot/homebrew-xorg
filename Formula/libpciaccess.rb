class Libpciaccess < Formula
  desc "X.Org Libraries: libpciaccess"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/pub/individual/lib/libpciaccess-0.15.tar.bz2"
  sha256 "a75643bb5cd02f6da8667d437b76492842dd56bc88e3dfb8410f5d535b99f5dc"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "5572e5c010dcbc3e787d277497f09249c629b9668b6e84397c3d41aeda2e0a72" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => :build

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
