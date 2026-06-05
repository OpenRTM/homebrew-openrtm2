#============================================================
# OpenRTM-aist formula for HomeBrew
#
# Author: Noriaki Ando <Noriaki.Ando@gmail.com>
# GitHub: https://github.com/OpenRTM/homebrew-openrtm
#
# This is the formula for OpenRTM-aist (C++) for python 3.11.
# To use this formula/bottle, switch python into python 3.11.
# $ brew unlink python3 (unlink python 3.X)
# $ brew link python@3.11
#============================================================
class Openrtm2Py311 < Formula
  desc "OpenRTM2: RT-Middleware and OMG RTC implementation in C++ implemented by AIST"
  homepage "https://openrtm.org"
  url "https://github.com/OpenRTM/OpenRTM-aist/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "3462bb01dacf69b058706e636cafd817e3abe97631b3056d0fa9d38f2e43fe6e"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/OpenRTM/homebrew-openrtm2/releases/download/2.1.0"
    rebuild 1
    sha256 cellar: :any, arm64_tahoe: "b4d36cf56ad56e3de16d6978d1621d9d6cf8d693cf99a6eebc6df07d3915e5af"
    rebuild 1
    sha256 cellar: :any, arm64_sequoia: "eeb6ab0ccc5a86290be542919cbe52374768788fecbf22d5c2fc60edcdb1b4f8"
  end




  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "openrtm/omniorb/omniorb-ssl-py311"


  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=${CMAKE_INSTALL_PREFIX}/lib"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "rtm2-config", "--help"
  end
end
