class Scrnsaverproto < Formula
  desc "X.Org Protocol Headers: scrnsaverproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/proto/scrnsaverproto-1.2.2.tar.bz2"
  sha256 "8bb70a8da164930cceaeb4c74180291660533ad3cc45377b30a795d1b85bcd65"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "f3191417f5d1dca7d1088fa919b6c019bd1995ad1f8920ae519014b85d89a248" => :x86_64_linux
  end

  option "with-specs", "Build specifications"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

  # Patch for xmlto
  patch do
    url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/master/patch_configure.diff"
    sha256 "e3aff4be9c8a992fbcbd73fa9ea6202691dd0647f73d1974ace537f3795ba15f"
  end

  if build.with?("specs")
    depends_on "xmlto" => :build
    depends_on "fop" => [:build, :recommended]
    depends_on "libxslt" => [:build, :recommended]
    depends_on "xorg-sgml-doctools" => [:build, :recommended]
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-specs=#{build.with?("specs") ? "yes" : "no"}"

    system "./configure", *args
    system "make", "install"
  end
end
