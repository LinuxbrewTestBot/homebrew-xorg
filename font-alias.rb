# font-alias: Build a bottle for Linuxbrew
class FontAlias < Formula
  desc "X.Org Fonts: font alias"
  homepage "http://www.x.org/"
  bottle do
    cellar :any_skip_relocation
    sha256 "1486363066ac2288cb10218c7fd9b1672f56e42e79f5853df122068bef063db8" => :x86_64_linux
  end

  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-alias-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-alias-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-alias-1.0.3.tar.bz2"
  sha256 "8b453b2aae1cfa8090009ca037037b8c5e333550651d5a158b7264ce1d472c9a"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"

    prefix.install "README" => "font-alias.md"
  end
end
