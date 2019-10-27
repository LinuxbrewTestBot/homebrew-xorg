class Xrandr < Formula
  desc "X.Org Applications: xrandr"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrandr-1.5.1.tar.xz"
  sha256 "7bc76daf9d72f8aff885efad04ce06b90488a1a169d118dea8a2b661832e8762"
  bottle do
    cellar :any_skip_relocation
    sha256 "9d9fff8263ea2e4681da6f7edc4594c1c34575066277edc5f53a81513720e6df" => :x86_64_linux
  end

  # tag "linuxbrew"

  option "without-xkeystone", "Delete (broken) xkeystone script"

  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxrandr"
  depends_on "linuxbrew/xorg/libxrender"

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
    rm bin/"xkeystone" if build.without?("xkeystone")
  end
end
