class IntelMediaDriver < Formula
  desc "Intel media driver for VAAPI"
  homepage "https://github.com/intel/media-driver"
  url "https://github.com/intel/media-driver/archive/intel-media-19.3.0.tar.gz"
  sha256 "7e523224867c9b0ebdaf944c0c7915d298562775bea9deddb94121148ad9b88b"

  bottle do
    cellar :any_skip_relocation
    sha256 "dd360d016b16afb4cf7732b0cc9bfff4ddc6791e407c39d1a1fcd0219a751a35" => :x86_64_linux
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
