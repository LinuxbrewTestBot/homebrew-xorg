# xcb-util: Build a bottle for Linuxbrew
class XcbUtil < Formula
  desc "Additional extensions to the XCB library."
  homepage "http://xcb.freedesktop.org"
  url "http://xcb.freedesktop.org/dist/xcb-util-0.4.0.tar.bz2"
  sha256 "46e49469cb3b594af1d33176cd7565def2be3fa8be4371d62271fabb5eae50e9"

  bottle do
    cellar :any_skip_relocation
    sha256 "c9b90cb2c9fa611e3b5d31a52d544fd6a173fc33cfd6f057f876ab7112bac179" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "libxcb"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--disable-static" if !build.with?("static")

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
