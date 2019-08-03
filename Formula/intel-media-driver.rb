class IntelMediaDriver < Formula
  desc "Intel media driver for VAAPI"
  homepage "https://github.com/intel/media-driver"
  url "https://github.com/intel/media-driver/archive/intel-media-19.2.1.tar.gz"
  sha256 "79279c991d918deaa52239dac55787b9c7562e520cd58744171b468d28b8af40"

  bottle do
    cellar :any_skip_relocation
    sha256 "c2a2cb7edddf864ae3b7db0a0f22051f23d074235eda7c851fb8835c8de0697f" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "linuxbrew/xorg/intel-gmmlib" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libva"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end
end
