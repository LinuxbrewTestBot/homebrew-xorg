class UtilMacros < Formula
  desc "X.Org util-macros"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://www.x.org/archive/individual/util/util-macros-1.19.0.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/util/util-macros-1.19.0.tar.bz2"
  sha256 "2835b11829ee634e19fa56517b4cfc52ef39acea0cd82e15f68096e27cbed0ba"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "1e9f190ddc263a8c4db04f91003e850061d5246f3668e404cbc6e772c75d112f" => :x86_64_linux
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
    ]

    system "./configure", *args
    system "make", "install"
  end
end
