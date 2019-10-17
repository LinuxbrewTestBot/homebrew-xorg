class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/intel-gmmlib-19.3.3.tar.gz"
  sha256 "aceb11fd61a895e30fc67c8a6230ffe8b44b2336fc2a81f5408b1b1a535763f5"

  bottle do
    cellar :any_skip_relocation
    sha256 "ae319a5015232afd4744fb9cd7b0c4ae1a3cdb00b34e41816ba61729ab4651ed" => :x86_64_linux
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DBUILD_TYPE=release"
      system "make"
      system "make", "install"
    end
  end
end
