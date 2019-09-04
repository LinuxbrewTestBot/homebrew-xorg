class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/intel-gmmlib-19.2.4.tar.gz"
  sha256 "180defcdb2ace03176307d3241ab58f075cd70a150ad9513df9cfa932c598e5b"

  bottle do
    cellar :any_skip_relocation
    sha256 "a458f170aeeb2264ac251e15bdbdc6691a4ec317ae73f241ce39966af5724915" => :x86_64_linux
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
