class Mesa < Formula
  desc "Mesa: cross-driver middleware"
  homepage "http://dri.freedesktop.org"
  url "https://mesa.freedesktop.org/archive/13.0.2/mesa-13.0.2.tar.xz"
  mirror "ftp://ftp.freedesktop.org/pub/mesa/13.0.2/mesa-13.0.2.tar.xz"
  sha256 "a6ed622645f4ed61da418bf65adde5bcc4bb79023c36ba7d6b45b389da4416d5"

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on :python => :build
  depends_on "flex"  => :build
  depends_on "bison" => :build
  depends_on "libtool" => :build

  depends_on "xorg"
  depends_on "libdrm"
  depends_on "libsha1"
  depends_on "systemd" # provides libudev <= needed by "gbm"
  depends_on "llvm"
  depends_on "libelf" # radeonsi requires libelf when using llvm
  depends_on "libomxil-bellagio"
  depends_on "wayland" => :recommended
  depends_on "valgrind" => :recommended
  depends_on "libglvnd" => :optional
  depends_on "libva" => :recommended
  depends_on "libvdpau"
  depends_on "autoconf" => :build if build.with?("libva") && build.without?("wayland")
  depends_on "libpthread-stubs" => :build

  #
  # There is a circular dependency between Mesa and libva:
  # libva should be installed:
  #  1. before Mesa with "disable-egl" and "disable-egl" options  [libva formula]
  #  2. after  Mesa without the above two options                 [this formula]
  #

  resource "mako" do
    url "https://pypi.python.org/packages/7a/ae/925434246ee90b42e8ef57d3b30a0ab7caf9a2de3e449b876c56dcb48155/Mako-1.0.4.tar.gz"
    sha256 "fed99dbe4d0ddb27a33ee4910d8708aca9ef1fe854e668387a9ab9a90cbf9059"
  end

  resource "libva" do
    url "https://www.freedesktop.org/software/vaapi/releases/libva/libva-1.7.2.tar.bz2"
    sha256 "5dd61cf16a5648b680e6146a58064e93be11bf4e65a9e4e30f1e9cb8ecfa2c13"
  end

  patch :p1 do
    url "http://www.linuxfromscratch.org/patches/blfs/svn/mesa-13.0.2-add_xdemos-1.patch"
    sha256 "53492ca476e3df2de210f749983e17de4bec026a904db826acbcbd1ef83e71cd"
  end

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j8" if ENV["CIRCLECI"]

    inreplace "configure.ac", "$SED -i -e 's/brw_blorp.cpp/brw_blorp.c/'", "# $SED -i -e 's/brw_blorp.cpp/brw_blorp.c/'"

    resource("mako").stage do
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end

    args = %W[
      CFLAGS=#{ENV.cflags}
      CXXFLAGS=#{ENV.cflags}
      --disable-silent-rules
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --enable-texture-float
      --enable-osmesa
      --enable-xa
      --enable-glx-tls
      --with-egl-platforms=drm,x11,surfaceless#{build.with?("wayland") ? ",wayland" : ""}
      --with-gallium-drivers=i915,nouveau,r300,r600,radeonsi,svga,swrast,swr
      --enable-dri
      --enable-dri3
      --enable-gallium-tests
      --enable-gbm
      --enable-gles1
      --enable-gles2
      --enable-glx
      --enable-opengl
      --enable-shared-glapi
      --enable-va
      --enable-vdpau
      --enable-xvmc
      --disable-llvm-shared-libs
      --with-dri-drivers=nouveau,radeon,r200,swrast
      --with-sha1=libsha1
    ]

    # --enable-gallium-llvm    | Causes build failure on Travis
    # --enable-gallium-osmesa
    # --enable-opencl

    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    if build.with?("libglvnd")
      args << "--enable-libglvnd"
    end

    inreplace "bin/ltmain.sh", /.*seems to be moved"/, '#\1seems to be moved"'

    system "./autogen.sh", *args
    system "make"
    system "make", "-C", "xdemos", "DEMOS_PREFIX=#{prefix}"
    system "make", "check" if build.with?("test")
    system "make", "install"
    system "make", "-C", "xdemos", "DEMOS_PREFIX=#{prefix}", "install"

    if build.with?("libva")
      resource("libva").stage do
        args = %W[
          --prefix=#{Formula["libva"].opt_prefix}
          --sysconfdir=#{etc}
          --localstatedir=#{var}
          --disable-dependency-tracking
          --disable-silent-rules
        ]

        # Be explicit about the configure flags
        args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

        ### Set environment flags:
        # $ pkg-config --cflags egl | tr ' ' '\n'
        # $ pkg-config --cflags gl  | tr ' ' '\n'
        ENV["EGL_CFLAGS"] = "-I#{include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libdrm"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libdrm"].opt_include}/libdrm"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxdamage"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["damageproto"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxfixes"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["fixesproto"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libx11"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxcb"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxxf86vm"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxext"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxau"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["libxdmcp"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["xproto"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["kbproto"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["xextproto"].opt_include}"
        ENV.append "EGL_CFLAGS", "-I#{Formula["xf86vidmodeproto"].opt_include}"

        ENV["GLX_CFLAGS"] = ENV["EGL_CFLAGS"]

        ENV["EGL_LIBS"] = "-L#{lib} -lEGL"
        ENV["GLX_LIBS"] = "-L#{lib} -lGL"

        system "autoreconf", "-fi" if build.without?("wayland") # needed only if Wayland is not installed
        system "./configure", *args
        system "make"
        system "make", "install"
      end
    end
  end

  test do
    output = shell_output("ldd #{lib}/libGL.so").chomp
    libs = %W[
      libxcb-dri3.so.0
      libxcb-present.so.0
      libxcb-randr.so.0
      libxcb-xfixes.so.0
      libxcb-render.so.0
      libxcb-shape.so.0
      libxcb-sync.so.1
      libxshmfence.so.1
      libglapi.so.0
      libXext.so.6
      libXdamage.so.1
      libXfixes.so.3
      libX11-xcb.so.1
      libX11.so.6
      libxcb-glx.so.0
      libxcb-dri2.so.0
      libxcb.so.1
      libXxf86vm.so.1
      libdrm.so.2
    ]
    libs << "libexpat.so.1" if build.with?("wayland")

    libs.each do |lib|
      assert_match lib, output
    end
  end
end
