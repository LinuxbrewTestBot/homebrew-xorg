class IntelMediaDriver < Formula
  desc "Intel media driver for VAAPI"
  homepage "https://github.com/intel/media-driver"
  url "https://github.com/intel/media-driver/archive/intel-media-19.3.1.tar.gz"
  sha256 "637471705567cc20d88aab0fdb552f62c9b3c530512765436642a1ec9f36134c"

  bottle do
    cellar :any_skip_relocation
    sha256 "d3eb52ab28d004dc7c07c0322ee3662095bb22aa5e7a96037f92adfafb93fa7f" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "linuxbrew/xorg/intel-gmmlib" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libva"

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j2" if ENV["CIRCLECI"]

    args = std_cmake_args + %w[
      -DBUILD_TYPE=Release
      -DUFO_MARCH=x86_64
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end
end
