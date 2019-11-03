class IntelGmmlib < Formula
  desc "Intel Graphics Memory Management Library"
  homepage "https://github.com/intel/gmmlib"
  url "https://github.com/intel/gmmlib/archive/intel-gmmlib-19.3.4.tar.gz"
  sha256 "5f08e36892db6bff8284913d9ab784f693d50e4ea1eb2ea6d2545e3dc6876b71"

  bottle do
    cellar :any_skip_relocation
    sha256 "3975c50c6048193d04d215e930ce4384b85b23d10e8e63f914a15e7b588703a6" => :x86_64_linux
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
