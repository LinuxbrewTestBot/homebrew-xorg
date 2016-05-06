# inputproto: Build a bottle for Linuxbrew
class Inputproto < Formula
  desc "X.Org Protocol Headers: inputproto"
  bottle do
    cellar :any_skip_relocation
    sha256 "c4ec367162b7b7fdaf076672426134b2b04da6b3c271723dba597ec81c01e6fd" => :x86_64_linux
  end

  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/inputproto-2.3.1.tar.bz2"
  sha256 "5a47ee62053a6acef3a83f506312494be1461068d0b9269d818839703b95c1d1"
  # tag "linuxbrew"

  option "with-specs",  "Build specifications"

  depends_on "pkg-config"         =>  :build
  depends_on "util-macros"        =>  :build

  if build.with?("specs")
    depends_on "asciidoc"         => :build
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
