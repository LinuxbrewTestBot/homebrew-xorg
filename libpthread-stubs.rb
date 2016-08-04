class LibpthreadStubs < Formula
  desc "X.Org Libraries: libpthread-stubs"
  homepage "http://www.x.org/"
  url "https://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2"
  sha256 "35b6d54e3cc6f3ba28061da81af64b9a92b7b757319098172488a660e3d87299"
  bottle do
    cellar :any_skip_relocation
    sha256 "398fc90f83d01c32dcafd50e8eabbccb78500b69454a42b762c56a348f0512ae" => :x86_64_linux
  end

  # tag "linuxbrew"

  depends_on "pkg-config"  => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert File.exist? "#{lib}/pkgconfig/pthread-stubs.pc"
  end
end
