class LibpthreadStubs < Formula
  desc "X.Org Libraries: libpthread-stubs"
  homepage "https://www.x.org/"
  url "https://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2"
  sha256 "35b6d54e3cc6f3ba28061da81af64b9a92b7b757319098172488a660e3d87299"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "94fb8ad7aa33cfbc99a61ed5c1e0e1e9be35c75403e03043db21ceb9da96e20f" => :x86_64_linux
  end

  depends_on "pkg-config" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_predicate lib/"pkgconfig/pthread-stubs.pc", :exist?
  end
end
