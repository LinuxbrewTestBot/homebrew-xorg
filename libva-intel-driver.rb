class LibvaIntelDriver < Formula
  desc "libva Intel driver"
  homepage "https://cgit.freedesktop.org/vaapi/intel-driver/"
  url "https://www.freedesktop.org/software/vaapi/releases/libva-intel-driver/libva-intel-driver-1.7.2.tar.bz2"
  sha256 "099e7bf6aa826971ec2caff235babf4da995f754e2ca16a73b258671130e67bc"

  bottle do
    cellar :any_skip_relocation
    sha256 "ac66e934899c489a79a132c9f7cf85c3a8799e15248462ebbac72fd6330b982e" => :x86_64_linux
  end

  # Build-time
  depends_on "pkg-config" => :build

  # Required
  depends_on "libva"

  # optional
  depends_on "wayland" => :recommended # if libva was built with wayland support

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"

    ohai "libva Intel driver has been installed"
    prefix.install "README" => "libva-intel-driver.md"
  end
end
